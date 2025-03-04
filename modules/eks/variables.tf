variable "cluster_name" {}
variable "cluster_version" {}
variable "vpc_id" {}
variable "subnet_ids" {
    type = list(string)
}
variable "ssh_key_name" {}
variable "custom_ami_id" {}
variable "aws_region" {}
variable "eks_worker_role_arn" {}
variable "environment" {}
variable "eks_security_group_id" {}