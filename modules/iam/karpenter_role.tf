resource "aws_iam_role" "karpenter_role" {
  name = "${var.cluster_name}-karpenter-role"
  assume_role_policy = data.aws_iam_policy_document.eks_assume_role_policy.json
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
  role       = aws_iam_role.karpenter_role.name
  policy_arn = aws_iam_policy.karpenter.arn
}

output "karpenter_role_arn" {
  value = aws_iam_role.karpenter_role.arn
}