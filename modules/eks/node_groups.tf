# Comment out or remove this file's contents as node groups are managed in main.tf

# resource "aws_eks_node_group" "worker_nodes" {
#   cluster_name    = module.eks.cluster_id
#   node_group_name = "worker-nodes"
#   node_role_arn   = var.eks_worker_role_arn
#   subnet_ids      = var.private_subnets
#
#   scaling_config {
#     desired_size = 2
#     max_size     = 3
#     min_size     = 1
#   }
#
#   instance_types = ["t3.medium"]
#   ami_type       = "AL2_x86_64"
#   
#   remote_access {
#     ec2_ssh_key = var.ssh_key_name
#   }
#
#   depends_on = [module.eks]
# }