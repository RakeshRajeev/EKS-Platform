# Central location for all IAM role outputs
output "worker_role_arn" {
  description = "ARN of the EKS worker role"
  value       = aws_iam_role.worker_role.arn
}

output "cluster_autoscaler_role_arn" {
  description = "ARN of the cluster autoscaler role"
  value       = var.create_oidc_roles ? aws_iam_role.cluster_autoscaler_role[0].arn : null
}

output "aws_lb_controller_role_arn" {
  description = "ARN of the AWS Load Balancer Controller role"
  value       = var.create_oidc_roles ? aws_iam_role.aws_lb_controller_role[0].arn : null
}

output "cert_manager_role_arn" {
  description = "ARN of the cert manager role"
  value       = var.create_oidc_roles ? aws_iam_role.cert_manager_role[0].arn : null
}

output "logging_role_arn" {
  description = "ARN of the logging role"
  value       = var.create_oidc_roles ? aws_iam_role.logging_role[0].arn : null
}