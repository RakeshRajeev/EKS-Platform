cluster_name       = "dev-eks-cluster"
aws_region         = "ap-south-1"
allowed_ssh_cidr   = "203.0.113.0/32"  # Replace with your IP
ssh_key_name       = "dev-eks-ssh" # Replace with your key pair name
environment        = "dev"
db_username        = "postgres"
db_password        = "Rake#1234"
# Remove the ami_id line since we're using dynamic lookup
iam_role_names     = ["eks-role-1"]
eks_worker_role_arn = "arn:aws:iam::123456789012:role/eks-worker-role"
enable_aws_lb_controller = true  # Add this line to enable the AWS Load Balancer Controller

# BEGIN: Static AMI configuration - Uncomment this block if you want to use a specific AMI
# ami_id             = "ami-0123456789abcdef0"  # Replace with your specific AMI ID
# END: Static AMI configuration
