module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.31"
  vpc_id          = var.vpc_id
  subnet_ids      = var.subnet_ids

  # Configure cluster endpoint access
  cluster_endpoint_public_access       = true
  cluster_endpoint_private_access      = true
  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]

  # Override the default IAM role creation to avoid using deprecated inline_policy
  create_iam_role = false
  iam_role_arn    = aws_iam_role.eks_cluster.arn

  # Fix KMS encryption configuration format
  cluster_encryption_config = {
    resources = ["secrets"]
    provider_key_arn = aws_kms_key.eks.arn
  }

  # Disable built-in addons since we're managing them separately
  cluster_addons = {}

  eks_managed_node_groups = {
    worker_nodes = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_types   = ["t3.medium"]
      key_name         = var.ssh_key_name
      ami_id           = var.ami_id
    }
  }
}

# Get current AWS account ID
data "aws_caller_identity" "current" {}

// Remove the following KMS resources as they are now in kms.tf
// resource "aws_kms_key" "eks" { ... }
// resource "aws_kms_alias" "eks" { ... }

data "tls_certificate" "eks" {
  url = module.eks.cluster_oidc_issuer_url
}

resource "aws_iam_openid_connect_provider" "eks" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks.certificates[0].sha1_fingerprint]
  url             = module.eks.cluster_oidc_issuer_url
}

# Create IAM role without inline policy
resource "aws_iam_role" "eks_cluster" {
  name = "${var.cluster_name}-eks-cluster-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

# Create separate policy
resource "aws_iam_role_policy" "eks_cluster_policy" {
  name = "${var.cluster_name}-eks-cluster-policy"
  role = aws_iam_role.eks_cluster.id
  policy = var.inline_policy
}

# Ensure exclusive policy management
resource "aws_iam_role_policies_exclusive" "eks_cluster" {
  role_name    = aws_iam_role.eks_cluster.name
  policy_names = [aws_iam_role_policy.eks_cluster_policy.name]
}

# Add required policies for EKS cluster
resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster.name
}

resource "aws_iam_role_policy_attachment" "eks_service_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks_cluster.name
}

// Remove or comment out the deprecated configuration
// resource "aws_iam_role" "this" { ... }
// resource "aws_iam_role_policy" "eks_policy" { ... }
// resource "aws_iam_role_policies_exclusive" "this" { ... }