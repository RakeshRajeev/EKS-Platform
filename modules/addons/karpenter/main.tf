resource "helm_release" "karpenter" {
  name       = "karpenter"
  namespace  = "karpenter"
  repository = "oci://public.ecr.aws/karpenter"
  chart      = "karpenter"
  version    = "v0.33.1"

  create_namespace = true

  dynamic "set" {
    for_each = {
      "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn" = var.karpenter_role_arn
      "clusterName"    = var.cluster_name
      "clusterEndpoint" = var.cluster_endpoint
      "aws.defaultInstanceProfile" = var.cluster_name
    }
    content {
      name  = set.key
      value = set.value
    }
  }
}
