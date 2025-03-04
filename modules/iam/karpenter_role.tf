resource "aws_iam_role" "karpenter" {
  name = "${var.cluster_name}-karpenter-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRoleWithWebIdentity"
      Effect = "Allow"
      Principal = {
        Federated = var.oidc_provider_arn
      }
      Condition = {
        StringEquals = {
          "${var.oidc_provider}:sub" = "system:serviceaccount:karpenter:karpenter"
        }
      }
    }]
  })
}

resource "aws_iam_policy" "karpenter" {
  name        = "${var.cluster_name}-karpenter-policy"
  description = "Policy for Karpenter"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = [
        "ec2:CreateLaunchTemplate",
        "ec2:CreateFleet",
        "ec2:RunInstances",
        "ec2:DescribeSubnets",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeLaunchTemplates",
        "ec2:DescribeInstances",
        "ec2:DescribeInstanceTypes",
        "ec2:DescribeInstanceTypeOfferings",
        "ec2:DescribeAvailabilityZones",
        "ec2:DeleteLaunchTemplate",
        "ec2:DeleteFleet",
        "ec2:TerminateInstances",
        "ssm:GetParameter",
        "iam:PassRole"
      ]
      Resource = "*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "karpenter" {
  role       = aws_iam_role.karpenter.name
  policy_arn = aws_iam_policy.karpenter.arn
}