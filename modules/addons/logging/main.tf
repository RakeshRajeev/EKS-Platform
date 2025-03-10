resource "helm_release" "fluent_bit" {
  name             = "fluent-bit"
  namespace        = "logging"
  repository       = "https://fluent.github.io/helm-charts"
  chart            = "fluent-bit"
  version          = "0.20.6"
  create_namespace = true

  values = [
    <<-EOT
    serviceAccount:
      create: true
      annotations:
        eks.amazonaws.com/role-arn: ${var.logging_role_arn}
    EOT
  ]

  dynamic "set" {
    for_each = var.logging_role_arn != "" ? [1] : []
    content {
      name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
      value = var.logging_role_arn
    }
  }
}
