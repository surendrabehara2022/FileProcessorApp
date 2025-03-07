terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.112.0"
    }
  }

 # required_version = "=1.3.2"
  required_version = ">= 1.11.0"
  backend "azurerm" {
    container_name = "tfstate"
    key            = "terraform.deployment.tfplan"
  }
}

#provider "azurerm" {
#  features {}
#}

provider "azurerm" {
  features {}
  subscription_id = 81e63c6d-7f3c-4e33-8a28-0036da979a43
}
