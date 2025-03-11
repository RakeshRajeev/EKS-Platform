resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  namespace        = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  version          = "v1.12.0"
  create_namespace = true

  values = [
    <<-EOT
    installCRDs: true
    serviceAccount:
      create: true
      annotations:
        eks.amazonaws.com/role-arn: ${var.cert_manager_role_arn}
    
    # Add DNS01 solver configuration
    solvers:
    - dns01:
        route53:
          region: ${var.aws_region}
    
    # Enable self-signed cluster issuer
    clusterIssuer:
      create: true
      name: "letsencrypt-prod"
      server: "https://acme-v02.api.letsencrypt.org/directory"
      email: ${var.cert_manager_email}
      privateKeySecretRef:
        name: "letsencrypt-prod"
      solvers:
      - dns01:
          route53:
            region: ${var.aws_region}
    EOT
  ]
}

# Wait longer for cert-manager webhook to be ready
resource "time_sleep" "wait_for_cert_manager" {
  depends_on = [helm_release.cert_manager]
  create_duration = "60s"  # Increased wait time
}

# Create cluster issuer
resource "kubectl_manifest" "cluster_issuer" {
  depends_on = [
    helm_release.cert_manager,
    time_sleep.wait_for_cert_manager
  ]
  yaml_body = <<-YAML
    apiVersion: cert-manager.io/v1
    kind: ClusterIssuer
    metadata:
      name: letsencrypt-prod
    spec:
      acme:
        server: https://acme-v02.api.letsencrypt.org/directory
        email: ${var.cert_manager_email}
        privateKeySecretRef:
          name: letsencrypt-prod
        solvers:
        - dns01:
            route53:
              region: ${var.aws_region}
  YAML
  provider = kubectl.this  # Explicitly specify the provider
}
