variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-west-2"
}

variable "inline_policy" {
  description = "IAM inline policy for the EKS role"
  type        = string
}

variable "iam_role_names" {
  description = "List of IAM role names for the EKS cluster"
  type        = list(string)
}

variable "ami_id" {
  description = "The AMI ID to use for the EKS worker nodes"
  type        = string
}

variable "eks_worker_role_arn" {
  description = "The ARN of the EKS worker role"
  type        = string
}
