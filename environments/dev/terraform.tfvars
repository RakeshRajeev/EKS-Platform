cluster_name       = "dev-eks-cluster"
aws_region         = "ap-south-1"
allowed_ssh_cidr   = "203.0.113.0/32"  # Replace with your IP
ssh_key_name       = "dev-eks-ssh" # Replace with your key pair name
environment        = "dev"
db_username        = "postgres"
db_password        = "Rake#1234"
ami_id             = "ami-eks111"
iam_role_names     = ["eks-role-1"]
eks_worker_role_arn = "arn:aws:iam::123456789012:role/eks-worker-role"
