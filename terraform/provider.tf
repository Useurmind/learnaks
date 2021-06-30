terraform {
  # this is the azure storage account where we save the terraform state
  backend "azurerm" {
    key = "prod.terraform.tfstate"
  }


  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.59.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "=1.5.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.3.2"
    }
    random = {
      source = "hashicorp/random"
      version = "3.1.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

data "azurerm_subscription" "primary" {
}

# this is the provider for the kubernetes cluster created in this script
provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.k8s.kube_admin_config.0.host
  username               = azurerm_kubernetes_cluster.k8s.kube_admin_config.0.username
  password               = azurerm_kubernetes_cluster.k8s.kube_admin_config.0.password
  client_certificate     = base64decode(azurerm_kubernetes_cluster.k8s.kube_admin_config.0.client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.k8s.kube_admin_config.0.client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.k8s.kube_admin_config.0.cluster_ca_certificate)
}

