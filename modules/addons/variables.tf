variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "cluster_autoscaler_role_arn" {
  description = "ARN of the Cluster Autoscaler IAM role"
  type        = string
  default     = ""
}

variable "aws_lb_controller_role_arn" {
  description = "ARN of the AWS Load Balancer Controller IAM role"
  type        = string
  default     = ""
}

variable "karpenter_role_arn" {
  description = "ARN of the Karpenter IAM role"
  type        = string
  default     = null
}

variable "cert_manager_role_arn" {
  description = "ARN of the Cert Manager IAM role"
  type        = string
  default     = ""
}

variable "db_username" {
  description = "Database username"
  type        = string
  default     = null
}

variable "db_password" {
  description = "Database password"
  type        = string
  default     = null
  sensitive   = true
}

variable "rds_security_group_id" {
  description = "ID of the RDS security group"
  type        = string
  default     = null
}

variable "private_subnets" {
  description = "List of private subnet IDs"
  type        = list(string)
  default     = []
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
  default     = ""
}

variable "cluster_endpoint" {
  description = "Endpoint of the EKS cluster"
  type        = string
  default     = null
}

variable "eks_oidc_provider_arn" {
  description = "ARN of the EKS OIDC provider"
  type        = string
  default     = null
}

variable "cert_manager_email" {
  description = "Email address for Let's Encrypt notifications"
  type        = string
  default     = null
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "eksdatabase"
}