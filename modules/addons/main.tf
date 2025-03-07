module "metrics_server" {
  source = "./metrics-server"
  count  = var.enable_metrics_server ? 1 : 0
}

module "cluster_autoscaler" {
  source = "./cluster-autoscaler"
  count  = var.enable_cluster_autoscaler ? 1 : 0

  cluster_name                = var.cluster_name
  aws_region                 = var.aws_region
  cluster_autoscaler_role_arn = var.cluster_autoscaler_role_arn
}

module "aws_lb_controller" {
  source = "./aws-lb-controller"
  count  = var.enable_aws_lb_controller ? 1 : 0

  cluster_name              = var.cluster_name
  aws_region               = var.aws_region
  aws_lb_controller_role_arn = var.aws_lb_controller_role_arn
}

module "cert_manager" {
  source = "./cert-manager"
  count  = var.enable_cert_manager ? 1 : 0

  cert_manager_role_arn = var.cert_manager_role_arn
}

module "argocd" {
  source = "./argocd"
  count  = var.enable_argocd ? 1 : 0
}

module "nginx_ingress" {
  source = "./nginx-ingress"
  count  = var.enable_nginx_ingress ? 1 : 0
}

module "rds" {
  source = "./rds"
  count  = var.enable_rds ? 1 : 0

  cluster_name           = var.cluster_name
  db_username           = var.db_username
  db_password           = var.db_password
  rds_security_group_id = var.rds_security_group_id
  private_subnets       = var.private_subnets
}

module "logging" {
  source = "./logging"
  count  = var.enable_logging ? 1 : 0

  cluster_name     = var.cluster_name
  aws_region      = var.aws_region
  logging_role_arn = var.logging_role_arn
}

module "karpenter" {
  source = "./karpenter"
  count  = var.enable_karpenter ? 1 : 0

  cluster_name       = var.cluster_name
  karpenter_role_arn = var.karpenter_role_arn
}