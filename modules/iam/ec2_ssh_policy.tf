resource "aws_iam_policy" "ec2_ssh_policy" {
  name   = "${var.cluster_name}-ec2-ssh-policy"
  policy = file("${path.module}/policies/ec2-ssh-policy.json")
}

resource "aws_iam_role_policy_attachment" "ec2_ssh_access" {
  count      = var.create_worker_role ? 1 : 0
  role       = aws_iam_role.worker_role.name  # Changed from eks_worker_role
  policy_arn = aws_iam_policy.ec2_ssh_policy.arn
}

output "ec2_ssh_policy_arn" {
  value = aws_iam_policy.ec2_ssh_policy.arn
}