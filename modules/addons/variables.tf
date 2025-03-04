variable "cluster_name" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "cluster_autoscaler_role_arn" {
  type = string
}

variable "aws_lb_controller_role_arn" {
  type = string
}

variable "karpenter_role_arn" {
  type = string
}

variable "cert_manager_role_arn" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}

variable "rds_security_group_id" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "ami_id" {
  type    = string
  default = null  # Replace with your AMI ID if needed
}