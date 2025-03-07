resource "helm_release" "argocd" {
  name       = "argocd"
  namespace  = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "5.34.1"

  create_namespace = true

  values = [
    <<-EOT
    server:
      service:
        type: LoadBalancer
    configs:
      secret:
        argocdServerAdminPassword: $2a$10$1YP7uDHIRGC3rT9yNhAb8uVEMGLE4eY.p2fGhkcBgKF.waOQ1QSgC
    EOT
  ]
}
