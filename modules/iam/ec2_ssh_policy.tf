resource "aws_iam_policy" "ec2_ssh_policy" {
  name   = "${var.cluster_name}-ec2-ssh-policy"
  policy = file("${path.module}/policies/ec2-ssh-policy.json")
}

resource "aws_iam_role_policy_attachment" "ec2_ssh_access" {
  count      = var.create_worker_role ? 1 : 0
  role       = aws_iam_role.eks_worker_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

output "ec2_ssh_policy_arn" {
  value = aws_iam_policy.ec2_ssh_policy.arn
}