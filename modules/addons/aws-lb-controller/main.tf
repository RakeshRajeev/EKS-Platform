resource "helm_release" "aws_load_balancer_controller" {
  name       = "aws-load-balancer-controller"
  namespace  = "kube-system"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  version    = "1.4.4"

  values = [
    <<-EOT
    serviceAccount:
      annotations:
        eks.amazonaws.com/role-arn: ${var.aws_lb_controller_role_arn}
    
    controller:
      service:
        annotations:
          service.beta.kubernetes.io/aws-load-balancer-type: nlb
          service.beta.kubernetes.io/aws-load-balancer-internal: "true"
          service.beta.kubernetes.io/aws-load-balancer-scheme: "internal"
          service.beta.kubernetes.io/aws-load-balancer-nlb-target-type: "ip"
          service.beta.kubernetes.io/aws-load-balancer-healthcheck-protocol: "HTTP"
          service.beta.kubernetes.io/aws-load-balancer-healthcheck-port: "8080"
          service.beta.kubernetes.io/aws-load-balancer-healthcheck-path: "/healthz"
    
    region: ${var.aws_region}
    vpcId: ${var.vpc_id}
    clusterName: ${var.cluster_name}
    EOT
  ]
}
