resource "aws_iam_role" "karpenter_role" {
  count = var.create_oidc_roles && var.oidc_provider_arn != "" ? 1 : 0
  name  = "${var.cluster_name}-karpenter-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "karpenter" {
  name = "${var.cluster_name}-karpenter-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:CreateLaunchTemplate",
          "ec2:DeleteLaunchTemplate",
          "ec2:CreateFleet",
          "ec2:RunInstances",
          "ec2:DescribeSpotPriceHistory",
          "pricing:GetProducts",
          "ec2:DescribeInstances",
          "ec2:TerminateInstances"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "karpenter_policy_attachment" {
  count      = var.create_oidc_roles && var.oidc_provider_arn != "" ? 1 : 0
  role       = aws_iam_role.karpenter_role[count.index].name
  policy_arn = aws_iam_policy.karpenter.arn
}

output "karpenter_role_arn" {
  value = var.create_oidc_roles && var.oidc_provider_arn != "" ? aws_iam_role.karpenter_role[0].arn : null
}