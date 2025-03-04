resource "aws_iam_role" "cert_manager" {
  name = "${var.cluster_name}-cert-manager-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRoleWithWebIdentity"
      Effect = "Allow"
      Principal = {
        Federated = var.oidc_provider_arn
      }
      Condition = {
        StringEquals = {
          "${var.oidc_provider}:sub" = "system:serviceaccount:cert-manager:cert-manager"
        }
      }
    }]
  })
}

resource "aws_iam_policy" "cert_manager" {
  name        = "${var.cluster_name}-cert-manager-policy"
  description = "Policy for Cert-Manager"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = [
        "route53:GetChange",
        "route53:ChangeResourceRecordSets",
        "route53:ListResourceRecordSets"
      ]
      Resource = "*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "cert_manager" {
  role       = aws_iam_role.cert_manager.name
  policy_arn = aws_iam_policy.cert_manager.arn
}