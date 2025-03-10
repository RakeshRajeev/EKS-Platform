variable "cluster_name" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
  sensitive = true
}

variable "db_name" {
  type    = string
  default = "eksdatabase"
}

variable "rds_security_group_id" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}
