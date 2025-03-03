module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = "1.31"
  vpc_id          = var.vpc_id
  subnet_ids      = var.subnet_ids

  cluster_endpoint_public_access = true
  cluster_endpoint_private_access = true

  node_groups = {
    workers = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_types   = ["t3.medium"]
      key_name         = var.ssh_key_name
      ami_id           = var.custom_ami_id
    }
  }
}