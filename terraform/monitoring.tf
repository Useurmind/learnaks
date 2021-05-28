resource "azurerm_log_analytics_workspace" "learnaks" {
  name                = "learnaksLogWs"
  location            = azurerm_resource_group.learn_aks.location
  resource_group_name = azurerm_resource_group.learn_aks.name
  sku                 = "PerGB2018"
  retention_in_days   = 32
}
