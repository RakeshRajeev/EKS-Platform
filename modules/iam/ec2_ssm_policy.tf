resource "aws_iam_policy" "ec2_ssm_policy" {
  name   = "${var.cluster_name}-ec2-ssm-policy"
  policy = file("${path.module}/policies/ec2-ssm-policy.json")
}

# Rename to avoid duplication
resource "aws_iam_role_policy_attachment" "ssm_custom" {
  count      = var.create_worker_role ? 1 : 0
  role       = aws_iam_role.eks_worker_role.name
  policy_arn = aws_iam_policy.ec2_ssm_policy.arn
}

# Rename to avoid duplication
resource "aws_iam_role_policy_attachment" "ssm_managed" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.eks_worker_role.name
}

output "ec2_ssm_policy_arn" {
  value = aws_iam_policy.ec2_ssm_policy.arn
}