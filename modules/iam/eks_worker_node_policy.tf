resource "aws_iam_role_policy_attachment" "eks_worker_node" {
  count      = var.create_worker_role ? 1 : 0
  role       = aws_iam_role.worker_role.name  # Changed from eks_worker_role
  policy_arn = aws_iam_policy.eks_worker_node_policy.arn
}

resource "aws_iam_policy" "eks_worker_node_policy" {
  name   = "${var.cluster_name}-eks-worker-node-policy"
  policy = file("${path.module}/policies/eks-worker-node-policy.json")
}

output "eks_worker_node_policy_arn" {
  value = aws_iam_policy.eks_worker_node_policy.arn
}