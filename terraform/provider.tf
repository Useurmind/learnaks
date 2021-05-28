terraform {
  # this is the azure storage account where we save the terraform state
  backend "azurerm" {
    resource_group_name  = "terraform_state_storage"
    storage_account_name = "jogterraform"
    container_name       = "tflearnaks"
    key                  = "prod.terraform.tfstate"
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
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
