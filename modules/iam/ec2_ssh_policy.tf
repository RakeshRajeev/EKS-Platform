resource "aws_iam_policy" "ec2_ssh_access" {
  name        = "${var.cluster_name}-ec2-ssh-access"
  description = "Policy for SSH access to EC2 instances"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["ec2:DescribeInstances", "ec2:StartInstances", "ec2:StopInstances"]
      Resource = "*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ec2_ssh_access" {
  role       = aws_iam_role.eks_worker.name
  policy_arn = aws_iam_policy.ec2_ssh_access.arn
}