terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = ">= 2.10"
      configuration_aliases = [kubernetes.this]
    }
    helm = {
      source = "hashicorp/helm"
      version = ">= 2.5"
      configuration_aliases = [helm.this]
    }
    kubectl = {
      source = "gavinbunney/kubectl"
      version = ">= 1.14"
      configuration_aliases = [kubectl.this]
    }
    aws = {
      source = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}
