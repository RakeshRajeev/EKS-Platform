# OIDC-related resources only
data "aws_iam_policy_document" "eks_assume_role_policy" {
  count = var.oidc_provider != null ? 1 : 0

  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Federated"
      identifiers = [var.oidc_provider_arn]
    }
    condition {
      test     = "StringEquals"
      variable = "${trimprefix(var.oidc_provider, "https://")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-node"]
    }
  }
}

# OIDC-dependent roles
resource "aws_iam_role" "cluster_autoscaler" {
  count = var.create_oidc_provider_role ? 1 : 0
  
  name = "${var.cluster_name}-cluster-autoscaler"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = var.oidc_provider_arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "${trimprefix(var.oidc_provider, "https://")}:sub": "system:serviceaccount:kube-system:cluster-autoscaler"
          }
        }
      }
    ]
  })
}

# Remove duplicate worker role and output definitions
