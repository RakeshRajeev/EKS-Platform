resource "aws_iam_role_policy_attachment" "eks_worker_node" {
  role       = aws_iam_role.eks_worker_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_policy" "eks_worker_node_policy" {
  name   = "${var.cluster_name}-eks-worker-node-policy"
  policy = file("${path.module}/policies/eks-worker-node-policy.json")
}

output "eks_worker_node_policy_arn" {
  value = aws_iam_policy.eks_worker_node_policy.arn
}