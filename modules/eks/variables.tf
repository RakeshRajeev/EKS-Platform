variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "The version of the EKS cluster"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the EKS cluster will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "The subnet IDs where the EKS cluster will be deployed"
  type        = list(string)
}

variable "private_subnets" {
  description = "The private subnet IDs where the EKS worker nodes will be deployed"
  type        = list(string)
}

variable "node_security_group_id" {
  description = "The security group ID for the EKS worker nodes"
  type        = string
}

variable "ssh_key_name" {
  description = "The SSH key name to use for the EKS worker nodes"
  type        = string
  default     = "dev-eks-ssh"  # Your EC2 key pair name
}

variable "eks_security_group_id" {
  description = "The security group ID for the EKS cluster"
  type        = string
}

variable "inline_policy" {
  description = "IAM inline policy for the EKS role"
  type        = string
}

variable "enable_logging" {
  description = "Enable logging for the EKS cluster"
  type        = bool
  default     = false
}

variable "iam_role_names" {
  description = "List of IAM role names for EKS"
  type        = list(string)
}

variable "ami_id" {
  description = "The AMI ID to use for the EKS worker nodes"
  type        = string
  default     = null  # Make the variable optional
}

variable "eks_worker_role_arn" {
  description = "The ARN of the EKS worker role"
  type        = string
}

variable "environment" {
  description = "The environment for the EKS cluster"
  type        = string
}