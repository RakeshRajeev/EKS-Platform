resource "helm_release" "karpenter" {
  name             = "karpenter"
  namespace        = "karpenter"
  repository       = "https://charts.karpenter.sh"
  chart            = "karpenter"
  version          = "0.16.3"
  create_namespace = true

  timeout = 300
  wait    = true
  atomic  = false

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
    name  = "settings.aws.defaultInstanceProfile"
    value = var.cluster_name
  }

  depends_on = [time_sleep.wait_for_eks]
}

# Add a wait for EKS readiness
resource "time_sleep" "wait_for_eks" {
  create_duration = "30s"
}

# Add post-installation wait
resource "kubernetes_job" "wait_for_karpenter" {
  depends_on = [helm_release.karpenter]

  metadata {
    name      = "wait-for-karpenter"
    namespace = "karpenter"
  }

  spec {
    template {
      metadata {}
      spec {
        container {
          name    = "wait"
          image   = "busybox"
          command = ["/bin/sh", "-c", "sleep 30"]
        }
        restart_policy = "Never"
      }
    }
    backoff_limit = 0
  }

  timeouts {
    create = "2m"
    delete = "2m"
  }
}
