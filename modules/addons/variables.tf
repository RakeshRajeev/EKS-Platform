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

variable "aws_lb_controller_role_arn" {
  description = "ARN of the AWS Load Balancer Controller IAM role"
  type        = string
}

variable "karpenter_role_arn" {
  description = "ARN of the Karpenter IAM role"
  type        = string
}

variable "cert_manager_role_arn" {
  description = "ARN of the Cert Manager IAM role"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "rds_security_group_id" {
  description = "ID of the RDS security group"
  type        = string
}

variable "private_subnets" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "ami_id" {
  type    = string
  default = null  # Replace with your AMI ID if needed
}

variable "enable_metrics_server" {
  description = "Enable metrics server addon"
  type        = bool
  default     = true
}

variable "enable_cluster_autoscaler" {
  description = "Enable cluster autoscaler addon"
  type        = bool
  default     = true
}

variable "enable_aws_lb_controller" {
  description = "Enable AWS Load Balancer Controller addon"
  type        = bool
  default     = true
}

variable "enable_cert_manager" {
  description = "Enable cert manager addon"
  type        = bool
  default     = true
}

variable "enable_karpenter" {
  description = "Enable Karpenter addon"
  type        = bool
  default     = true
}

variable "enable_argocd" {
  description = "Enable ArgoCD addon"
  type        = bool
  default     = true
}

variable "enable_nginx_ingress" {
  description = "Enable NGINX ingress addon"
  type        = bool
  default     = true
}

variable "enable_rds" {
  description = "Enable RDS addon"
  type        = bool
  default     = true
}

variable "enable_logging" {
  description = "Enable logging addon"
  type        = bool
  default     = true
}

variable "logging_role_arn" {
  description = "ARN of the logging IAM role"
  type        = string
}