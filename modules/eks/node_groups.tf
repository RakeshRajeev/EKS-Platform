resource "aws_eks_node_group" "worker_nodes" {
  cluster_name    = module.eks.cluster_id
  node_group_name = "${var.cluster_name}-worker-nodes"
  node_role_arn   = var.eks_worker_role_arn
  subnet_ids      = var.private_subnets

  scaling_config {
    desired_size = 3
    max_size     = 5
    min_size     = 1
  }

  launch_template {
    id      = aws_launch_template.eks_nodes.id
    version = aws_launch_template.eks_nodes.latest_version
  }

  remote_access {
    ec2_ssh_key               = var.ssh_key_name
    source_security_group_ids = [var.eks_security_group_id]
  }

  tags = {
    Environment = var.environment
  }
}