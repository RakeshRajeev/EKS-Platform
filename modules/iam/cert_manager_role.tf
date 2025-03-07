resource "aws_iam_role" "cert_manager_role" {
  name = "${var.cluster_name}-cert-manager-role"
  assume_role_policy = data.aws_iam_policy_document.eks_assume_role_policy.json
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

resource "aws_iam_role_policy_attachment" "cert_manager_policy_attachment" {
  role       = aws_iam_role.cert_manager_role.name
  policy_arn = aws_iam_policy.cert_manager.arn
}

output "cert_manager_role_arn" {
  value = aws_iam_role.cert_manager_role.arn
}