resource "aws_s3_bucket" "logs" {
  bucket = "${var.cluster_name}-logs"
}

resource "aws_s3_bucket_lifecycle_configuration" "logs" {
  bucket = aws_s3_bucket.logs.id

  rule {
    id     = "60-day-retention"
    status = "Enabled"

    expiration {
      days = 60
    }
  }
}

resource "helm_release" "fluent_bit" {
  name       = "fluent-bit"
  repository = "https://fluent.github.io/helm-charts"
  chart      = "fluent-bit"
  version    = "0.20.1"
  namespace  = "logging"

  set {
    name  = "backend.type"
    value = "s3"
  }

  set {
    name  = "backend.s3.bucket"
    value = aws_s3_bucket.logs.id
  }

  set {
    name  = "backend.s3.region"
    value = var.aws_region
  }
}