# a log analytics workspace that will be integrated with the aks cluster

resource "azurerm_log_analytics_workspace" "learnaks" {
  name                = var.log_storage_account_name
  location            = azurerm_resource_group.learn_aks.location
  resource_group_name = var.log_storage_account_rg
  sku                 = "PerGB2018"
  retention_in_days   = 32
}
