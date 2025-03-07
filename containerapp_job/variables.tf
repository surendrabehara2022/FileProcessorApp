variable "resource_group_name" {
  type    = string
  default = "containerjobrg"
}

variable "location" {
  type    = string
  default = "uksouth"
}

variable "subscription_id" {
  type    = string
  default = "81e63c6d-7f3c-4e33-8a28-0036da979a43"
}

locals {
  env_name           = "dev"
  service_name       = "poc"  
  tags = {
    ENVIRONMENT               = local.env_name
    SERVICE_OWNER             = "Mastek"
    RESPONSIBLE_TEAM          = "Mastek"
    }
  }