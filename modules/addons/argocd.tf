resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "4.9.7"
  namespace  = "argocd"

  set {
    name  = "server.service.type"
    value = "LoadBalancer"
  }
}