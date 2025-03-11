variable "cert_manager_role_arn" {
  description = "ARN of the Cert Manager IAM role"
  type        = string
}

variable "cert_manager_email" {
  description = "Email address for Let's Encrypt notifications"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}
