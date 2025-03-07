variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "cluster_autoscaler_role_arn" {
  description = "ARN of the Cluster Autoscaler IAM role"
  type        = string
}
