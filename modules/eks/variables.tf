variable "cluster_name" {}
variable "cluster_version" {}
variable "vpc_id" {}
variable "subnet_ids" {
    type = list(string)
}
variable "aws_region" {}
variable "eks_worker_role_arn" {}
variable "environment" {}
variable "ami_id" {
  type    = string
  default = null  # Optional, set to null if not using a custom AMI
}
variable "private_subnets" {
  type = list(string)
}
variable "node_security_group_id" {
  type    = string
}
variable "ssh_key_name" {
  type    = string
  default = "dev-eks-ssh"  # Your EC2 key pair name
}