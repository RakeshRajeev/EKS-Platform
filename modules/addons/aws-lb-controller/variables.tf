variable "cluster_name" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "aws_lb_controller_role_arn" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "eks_oidc_provider_arn" {
  type = string
}
