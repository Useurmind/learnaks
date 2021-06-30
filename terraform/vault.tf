resource "azurerm_key_vault" "vault" {
  name                        = "${var.cluster_name}Vault"
  location                    = azurerm_resource_group.learn_aks.location
  resource_group_name         = azurerm_resource_group.learn_aks.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azuread_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
}