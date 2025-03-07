variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "logging_role_arn" {
  description = "ARN of the logging IAM role"
  type        = string
}
