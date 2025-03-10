resource "aws_iam_role" "aws_lb_controller_role" {
  count = var.create_oidc_roles ? 1 : 0
  name  = "${var.cluster_name}-aws-lb-controller-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Federated = var.oidc_provider_arn
      }
      Action = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringEquals = {
          "${trimprefix(var.oidc_provider, "https://")}:sub": "system:serviceaccount:kube-system:aws-load-balancer-controller"
        }
      }
    }]
  })
}

resource "aws_iam_policy" "aws_lb_controller" {
  name        = "${var.cluster_name}-aws-lb-controller-policy"
  description = "Policy for AWS Load Balancer Controller"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSubnets",
          "ec2:DescribeVpcs",
          "elasticloadbalancing:*",
          "iam:CreateServiceLinkedRole",
          "ec2:DescribeInstances",
          "ec2:DescribeTags",
          "ec2:DescribeVpcPeeringConnections"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "aws_lb_controller" {
  count      = var.create_oidc_roles ? 1 : 0
  role       = aws_iam_role.aws_lb_controller_role[0].name
  policy_arn = aws_iam_policy.aws_lb_controller.arn
}