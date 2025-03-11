terraform {
  required_providers {
    kubectl = {
      source                = "gavinbunney/kubectl"
      version               = ">= 1.14"
      configuration_aliases = [kubectl.this]
    }
    helm = {
      source                = "hashicorp/helm"
      version               = ">= 2.5"
      configuration_aliases = [helm.this]
    }
  }
}
