resource "helm_release" "karpenter" {
  name             = "karpenter"
  namespace        = "karpenter"
  repository       = "oci://public.ecr.aws/karpenter/karpenter"
  chart            = "karpenter"
  version          = "v0.30.0"  # Using a stable version
  create_namespace = true

  timeout = 600  # 10 minutes
  wait    = true
  atomic  = false  # Allow manual cleanup if needed

  values = [
    <<-EOT
    serviceAccount:
      create: true
      name: karpenter
      annotations:
        eks.amazonaws.com/role-arn: ${var.karpenter_role_arn}
    controller:
      resources:
        requests:
          cpu: 200m
          memory: 512Mi
        limits:
          cpu: 500m
          memory: 1Gi
      logLevel: debug  # For troubleshooting
    settings:
      aws:
        clusterName: ${var.cluster_name}
        clusterEndpoint: ${var.cluster_endpoint}
        defaultInstanceProfile: ${var.cluster_name}
        interruptionQueueName: ${var.cluster_name}
        isolatedVPC: "false"
    EOT
  ]

  set {
    name  = "aws.defaultInstanceProfile"
    value = var.cluster_name
  }
}

# Wait for karpenter webhook
resource "time_sleep" "wait_for_karpenter" {
  depends_on = [helm_release.karpenter]
  create_duration = "30s"
}
