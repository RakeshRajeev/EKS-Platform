provider "aws" {
  region = var.aws_region
  profile= "my-profile"
}

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

  cluster_name       = var.cluster_name
  oidc_provider_arn  = module.eks.oidc_provider_arn
  oidc_provider      = module.eks.oidc_issuer_url
}

module "eks" {
  source = "../../modules/eks"

  cluster_name          = var.cluster_name
  cluster_version       = "1.31"
  vpc_id                = module.vpc.vpc_id
  subnet_ids            = module.vpc.private_subnets
  eks_security_group_id = module.vpc.eks_security_group_id
  ssh_key_name          = var.ssh_key_name
  private_subnets       = module.vpc.private_subnets
  node_security_group_id = module.vpc.node_security_group_id 
  inline_policy         = file("${path.module}/../../policies/eks-inline-policy.json")
  iam_role_names        = var.iam_role_names
  ami_id                = var.ami_id
  eks_worker_role_arn   = module.iam.eks_worker_role_arn
  environment           = var.environment
}

module "addons" {
  source = "../../modules/addons"

  cluster_name                  = var.cluster_name
  aws_region                    = var.aws_region
  cluster_autoscaler_role_arn   = module.iam.cluster_autoscaler_role_arn
  aws_lb_controller_role_arn    = module.iam.aws_lb_controller_role_arn
  karpenter_role_arn            = module.iam.karpenter_role_arn
  db_username                   = var.db_username
  db_password                   = var.db_password
  rds_security_group_id         = module.vpc.eks_security_group_id
  cert_manager_role_arn         = module.iam.cert_manager_role_arn
  private_subnets               = module.vpc.private_subnets
}

// Manage IAM roles and policies separately
data "aws_iam_policy_document" "eks_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eks_override" {
  for_each = toset(var.iam_role_names)
  name = each.value
  assume_role_policy = data.aws_iam_policy_document.eks_assume_role_policy.json
}

// Update IAM roles and policies to use aws_iam_role_policy
resource "aws_iam_role_policy" "eks_override" {
  for_each = toset(var.iam_role_names)
  name     = "${each.value}-eks-policy"
  role     = aws_iam_role.eks_override[each.key].id
  policy   = file("${path.module}/../../policies/eks-inline-policy.json")
}