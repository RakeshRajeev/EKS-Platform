resource "helm_release" "cluster_autoscaler" {
  name       = "cluster-autoscaler"
  namespace  = "kube-system"
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"
  version    = "9.29.0"

  set {
    name  = "awsRegion"
    value = var.aws_region
  }

  set {
    name  = "autoDiscovery.clusterName"
    value = var.cluster_name
  }

  dynamic "set" {
    for_each = var.cluster_autoscaler_role_arn != "" ? [1] : []
    content {
      name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
      value = var.cluster_autoscaler_role_arn
    }
  }
}
