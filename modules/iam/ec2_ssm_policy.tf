resource "aws_iam_policy" "ec2_ssm_policy" {
  name   = "${var.cluster_name}-ec2-ssm-policy"
  policy = file("${path.module}/policies/ec2-ssm-policy.json")
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.eks_worker_role.name
  policy_arn = aws_iam_policy.ec2_ssm_policy.arn
}

output "ec2_ssm_policy_arn" {
  value = aws_iam_policy.ec2_ssm_policy.arn
}