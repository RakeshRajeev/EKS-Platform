resource "aws_iam_role" "cert_manager_role" {
  count = var.create_oidc_roles ? 1 : 0
  name  = "${var.cluster_name}-cert-manager-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Federated = var.oidc_provider_arn
      }
      Action = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringEquals = {
          "${trimprefix(var.oidc_provider, "https://")}:sub" : "system:serviceaccount:cert-manager:cert-manager"
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
      Effect = "Allow"
      Action = [
        "route53:GetChange",
        "route53:ChangeResourceRecordSets",
        "route53:ListResourceRecordSets"
      ]
      Resource = "*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "cert_manager_policy_attachment" {
  count      = var.create_oidc_roles ? 1 : 0
  role       = aws_iam_role.cert_manager_role[0].name
  policy_arn = aws_iam_policy.cert_manager.arn
}