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
    resource_group_name  = "tfstatesa"
    storage_account_name = "tf0001sa"
    container_name = "tfstate"
    key            = "terraform.deployment.tfplan"
    use_oidc             = true
    subscription_id      = "81e63c6d-7f3c-4e33-8a28-0036da979a43"
    tenant_id            = "add1c500-a6d7-4dbd-b890-7f8cb6f7d861"
  }
}

provider "azurerm" {
  use_oidc = true
  features {}
}
