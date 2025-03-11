module "vpc" {
  source = "../../modules/vpc"

  cluster_name        = var.cluster_name
  vpc_cidr            = "10.0.0.0/16"
  public_subnets      = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets     = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zones  = ["${var.aws_region}a", "${var.aws_region}b"]
  allowed_ssh_cidr    = var.allowed_ssh_cidr
}

module "iam" {
  source = "../../modules/iam"
  cluster_name = var.cluster_name
}

module "eks" {
  source = "../../modules/eks"

  cluster_name           = var.cluster_name
  cluster_version       = "1.31"
  vpc_id                = module.vpc.vpc_id
  subnet_ids            = module.vpc.private_subnets
  eks_security_group_id = module.vpc.eks_security_group_id
  eks_worker_role_arn   = module.iam.worker_role_arn  # Using the correct output
  private_subnets       = module.vpc.private_subnets
  node_security_group_id = module.vpc.node_security_group_id
}

module "addons" {
  source = "../../modules/addons"

  providers = {
    kubernetes.this = kubernetes
    helm.this      = helm.this
    kubectl.this   = kubectl.this
  }

  cluster_name                = var.cluster_name
  aws_region                 = var.aws_region
  vpc_id                     = module.vpc.vpc_id
  private_subnets            = module.vpc.private_subnets
  cluster_endpoint           = module.eks.cluster_endpoint
  eks_oidc_provider_arn      = module.eks.oidc_provider_arn
  karpenter_role_arn         = try(module.iam.karpenter_role_arn, null)

  # Add RDS configuration
  enable_rds           = true
  db_username         = var.db_username
  db_password         = var.db_password
  rds_security_group_id = module.vpc.rds_security_group_id

  enable_cert_manager = true
  cert_manager_email = "your-email@example.com"  # Add this variable

  depends_on = [module.eks]
}