variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "oidc_provider_arn" {
  description = "The ARN of the OIDC Provider"
  type        = string
  default     = ""
}

variable "oidc_provider" {
  description = "The OIDC Provider URL"
  type        = string
  default     = ""
}

variable "create_oidc_roles" {
  description = "Whether to create OIDC-dependent roles"
  type        = bool
  default     = false
}

variable "create_worker_role" {
  description = "Whether to create the worker role"
  type        = bool
  default     = true
}

variable "create_oidc_provider_role" {
  description = "Whether to create OIDC provider role"
  type        = bool
  default     = false
}