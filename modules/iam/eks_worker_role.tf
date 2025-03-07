resource "aws_iam_role" "eks_worker_role" {
  name = "${var.cluster_name}-eks-worker-role"
  assume_role_policy = data.aws_iam_policy_document.eks_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "eks_worker_role_policy_attachment" {
  role       = aws_iam_role.eks_worker_role.name
  policy_arn = aws_iam_policy.eks_worker_node_policy.arn
}

output "eks_worker_role_arn" {
  value = aws_iam_role.eks_worker_role.arn
}