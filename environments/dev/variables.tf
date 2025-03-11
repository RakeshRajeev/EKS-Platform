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
  default     = null  # Make the variable optional
}

variable "iam_role_names" {
  description = "List of IAM role names for the EKS cluster"
  type        = list(string)
}

variable "eks_worker_role_arn" {
  description = "The ARN of the EKS worker role"
  type        = string
}

// Remove these variables as they're not needed
// variable "inline_policy" {
//   description = "IAM inline policy for the EKS role"
//   type        = string
//   default     = null
// }

variable "enable_aws_lb_controller" {
  description = "Enable AWS Load Balancer Controller addon"
  type        = bool
  default     = true
}

variable "cert_manager_email" {
  description = "Email address for Let's Encrypt notifications"
  type        = string
}

variable "db_name" {
  description = "Name of the database"
  type        = string
  default     = "eksdb"
}

variable "enable_rds" {
  description = "Whether to enable RDS"
  type        = bool
  default     = false
}