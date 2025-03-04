output "aws_lb_controller_role_arn" {
  value = aws_iam_role.aws_lb_controller.arn
}

output "cert_manager_role_arn" {
  value = aws_iam_role.cert_manager.arn
}

output "cluster_autoscaler_role_arn" {
  value = aws_iam_role.cluster_autoscaler.arn
}

output "karpenter_role_arn" {
  value = aws_iam_role.karpenter.arn
}