terraform {
  required_version = ">= 1.0"

  required_providers {
    kubernetes = {
      source                = "hashicorp/kubernetes"
      version              = ">= 2.10"
      configuration_aliases = [kubernetes]
    }
    helm = {
      source                = "hashicorp/helm"
      version              = ">= 2.5"
      configuration_aliases = [helm]
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}
