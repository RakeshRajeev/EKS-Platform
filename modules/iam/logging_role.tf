resource "aws_iam_role" "logging_role" {
  name = "${var.cluster_name}-logging-role"
  assume_role_policy = data.aws_iam_policy_document.eks_assume_role_policy.json
}

resource "aws_iam_policy" "logging_policy" {
  name        = "${var.cluster_name}-logging-policy"
  description = "Policy for EKS logging with Fluent Bit"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "cloudwatch:PutLogEvents",
          "cloudwatch:DescribeLogStreams",
          "cloudwatch:DescribeLogGroups",
          "cloudwatch:CreateLogStream",
          "cloudwatch:CreateLogGroup",
          "cloudwatch:PutRetentionPolicy"
        ]
        Resource = [
          "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/eks/${var.cluster_name}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "logging_policy_attachment" {
  role       = aws_iam_role.logging_role.name
  policy_arn = aws_iam_policy.logging_policy.arn
}

output "logging_role_arn" {
  value = aws_iam_role.logging_role.arn
}
