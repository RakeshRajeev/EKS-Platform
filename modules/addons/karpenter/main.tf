resource "helm_release" "karpenter" {
  name             = "karpenter"
  namespace        = "karpenter"
  repository       = "https://charts.karpenter.sh"  # Changed from ECR to standard Helm repo
  chart            = "karpenter"
  version          = "v0.33.1"
  create_namespace = true

  timeout = 900  # 15 minutes timeout

  values = [
    <<-EOT
    serviceAccount:
      create: true
      annotations:
        eks.amazonaws.com/role-arn: ${var.karpenter_role_arn}
    settings:
      aws:
        clusterName: ${var.cluster_name}
        clusterEndpoint: ${var.cluster_endpoint}
        defaultInstanceProfile: ${var.cluster_name}
        interruptionQueueName: ${var.cluster_name}
    controller:
      resources:
        requests:
          cpu: "1"
          memory: "1Gi"
        limits:
          cpu: "1"
          memory: "1Gi"
    EOT
  ]

  depends_on = [var.cluster_endpoint]  # Ensure cluster is ready
}
