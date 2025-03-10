resource "aws_iam_role" "eks_cluster_role" {
  count = var.create_oidc_roles && var.oidc_provider_arn != "" ? 1 : 0
  name  = "${var.cluster_name}-eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy_attachment" {
  count      = var.create_oidc_roles && var.oidc_provider_arn != "" ? 1 : 0
  role       = aws_iam_role.eks_cluster_role[count.index].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

output "eks_cluster_role_arn" {
  value = var.create_oidc_roles && var.oidc_provider_arn != "" ? aws_iam_role.eks_cluster_role[0].arn : null
}