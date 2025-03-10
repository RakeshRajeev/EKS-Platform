output "worker_role_arn" {
  description = "ARN of the EKS worker node IAM role"
  value       = aws_iam_role.eks_worker_role.arn
}