terraform {
  backend "s3" {
    bucket         = "dev-eks-terraform-state-001"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "terraform-state-locks"
  }
}
