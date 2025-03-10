variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "karpenter_role_arn" {
  description = "ARN of the Karpenter IAM role"
  type        = string
  default     = ""  # Make it optional with default empty string
}

variable "cluster_endpoint" {
  description = "Endpoint of the EKS cluster"
  type        = string
  default     = ""  # Make it optional with default empty string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"  # Add default region
}
