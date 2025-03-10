variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
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
