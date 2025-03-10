resource "aws_iam_policy" "ecr_readonly_policy" {
  name   = "${var.cluster_name}-ecr-readonly-policy"
  policy = file("${path.module}/policies/ecr-readonly-policy.json")
}

resource "aws_iam_role_policy_attachment" "ec2_container_registry" {
  count      = var.create_worker_role ? 1 : 0
  role       = aws_iam_role.worker_role.name  # Changed from eks_worker_role
  policy_arn = aws_iam_policy.ecr_readonly_policy.arn
}

output "ecr_readonly_policy_arn" {
  value = aws_iam_policy.ecr_readonly_policy.arn
}