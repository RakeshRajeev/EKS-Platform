module "vpc" {
  source = "./modules/vpc"
  aws_region = var.aws_region
}

module "eks" {
  source     = "./modules/eks"
  cluster_name = var.cluster_name
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.private_subnets
  ssh_key_name = var.ssh_key_name
  custom_ami_id = var.custom_ami_id
}

module "addons" {
  source      = "./modules/addons"
  cluster_name = var.cluster_name
}