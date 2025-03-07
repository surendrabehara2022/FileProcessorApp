resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = local.tags
}

resource "azurerm_user_assigned_identity" "user_assigned_identity" {
  name                = "user-identity"
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_role_assignment" "owner_assignment" {
  scope                = "/subscriptions/${var.subscription_id}"
  role_definition_name = "Owner"
  principal_id         = azurerm_user_assigned_identity.user_assigned_identity.principal_id
}

resource "azurerm_role_assignment" "contributor_assignment" {
  scope                = "/subscriptions/${var.subscription_id}"
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.user_assigned_identity.principal_id
}

resource "azurerm_role_assignment" "acr_pull" {
  principal_id   	= azurerm_user_assigned_identity.user_assigned_identity.principal_id
  role_definition_name  = "AcrPull"
  scope                 = azurerm_container_registry.acr.id
}

resource "azurerm_container_registry" "acr" {
  name                = "mytestacr001"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true
  tags                = local.tags
}

resource "azurerm_container_app_environment" "env" {
  name                = "${local.env_name}-app-env"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags     = local.tags
}

resource "azurerm_container_app_job" "container_app_job" {
  name                         = "${local.env_name}containerappjob"
  location                     = var.location
  resource_group_name          = var.resource_group_name
  container_app_environment_id = azurerm_container_app_environment.env.id

  replica_timeout_in_seconds = 10
  replica_retry_limit        = 10

  schedule_trigger_config {
    cron_expression = "*/5 * * * *"
    parallelism     = 1
  }

  template {
    container {
      image = "mytestacr001.azurecr.io/myconsoleapp:latest"
      name  = "containerappjob"
      cpu    = 0.5
      memory = "1Gi"
    }
 }
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.user_assigned_identity.id]
  }
}
