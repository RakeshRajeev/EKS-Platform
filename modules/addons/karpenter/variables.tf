variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "karpenter_role_arn" {
  description = "ARN of the Karpenter IAM role"
  type        = string
}

variable "cluster_endpoint" {
  description = "Endpoint of the EKS cluster"
  type        = string
}
