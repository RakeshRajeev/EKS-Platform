resource "helm_release" "metrics_server" {
  name       = "metrics-server"
  namespace  = "kube-system"
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  version    = "3.10.0"

  set {
    name  = "args[0]"
    value = "--kubelet-preferred-address-types=InternalIP"
  }
}
