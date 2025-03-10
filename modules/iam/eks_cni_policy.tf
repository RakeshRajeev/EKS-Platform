resource "aws_iam_policy" "eks_cni_policy" {
  name   = "${var.cluster_name}-eks-cni-policy"
  policy = file("${path.module}/policies/eks-cni-policy.json")
}

resource "aws_iam_role_policy_attachment" "eks_cni" {
  count      = var.create_worker_role ? 1 : 0
  role       = aws_iam_role.worker_role.name  # Changed from eks_worker_role
  policy_arn = aws_iam_policy.eks_cni_policy.arn
}

output "eks_cni_policy_arn" {
  value = aws_iam_policy.eks_cni_policy.arn
}