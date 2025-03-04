variable "cluster_name" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "allowed_ssh_cidr" {
  type = string
}

variable "ssh_key_name" {
  type = string
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
  type    = string
  default = null
}