resource "aws_iam_role_policy_attachment" "ec2_container_registry" {
  role       = aws_iam_role.eks_worker.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}