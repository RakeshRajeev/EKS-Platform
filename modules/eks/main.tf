module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"  # Use the latest version

  cluster_name    = var.cluster_name
  cluster_version = "1.31"
  vpc_id          = var.vpc_id
  subnet_ids      = var.subnet_ids

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  eks_managed_node_groups = {
    worker_nodes = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_types   = ["t3.medium"]
      key_name         = var.ssh_key_name
      ami_id           = var.custom_ami_id  # Use `ami_id`, not `custom_ami_id`
    }
  }
}

# Define OIDC provider and TLS certificate OUTSIDE the module block
data "tls_certificate" "eks" {
  url = module.eks.cluster_oidc_issuer_url
}

resource "aws_iam_openid_connect_provider" "eks" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks.certificates[0].sha1_fingerprint]
  url             = module.eks.cluster_oidc_issuer_url
}