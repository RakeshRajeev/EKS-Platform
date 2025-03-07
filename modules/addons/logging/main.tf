resource "helm_release" "fluent_bit" {
  name       = "fluent-bit"
  namespace  = "logging"
  repository = "https://fluent.github.io/helm-charts"
  chart      = "fluent-bit"
  version    = "0.20.6"

  create_namespace = true

  set {
    name  = "config.outputs"
    value = <<EOF
[OUTPUT]
    Name cloudwatch
    Match *
    region ${var.aws_region}
    log_group_name /aws/eks/${var.cluster_name}/logs
    log_stream_prefix fluent-bit-
    auto_create_group true
EOF
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = var.logging_role_arn
  }
}
