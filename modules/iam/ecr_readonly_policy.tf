resource "aws_iam_policy" "ecr_readonly_policy" {
  name   = "${var.cluster_name}-ecr-readonly-policy"
  policy = file("${path.module}/policies/ecr-readonly-policy.json")
}

resource "aws_iam_role_policy_attachment" "ec2_container_registry" {
  role       = aws_iam_role.eks_worker_role.name
  policy_arn = aws_iam_policy.ecr_readonly_policy.arn
}

output "ecr_readonly_policy_arn" {
  value = aws_iam_policy.ecr_readonly_policy.arn
}