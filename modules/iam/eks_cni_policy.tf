resource "aws_iam_role_policy_attachment" "eks_cni" {
  role       = aws_iam_role.eks_worker.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}