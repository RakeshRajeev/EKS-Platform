variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "aws_region" {
  type = string
}

variable "allowed_ssh_cidr" {
  type = string
}

variable "ssh_key_name" {
  description = "The SSH key name to use for the EKS worker nodes"
  type        = string
}

variable "environment" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}

variable "ami_id" {
  description = "The AMI ID to use for the EKS worker nodes"
  type        = string
}

variable "iam_role_names" {
  description = "List of IAM role names for the EKS cluster"
  type        = list(string)
}

variable "eks_worker_role_arn" {
  description = "The ARN of the EKS worker role"
  type        = string
}

variable "inline_policy" {
  description = "IAM inline policy for the EKS role"
  type        = string
  default     = null
}