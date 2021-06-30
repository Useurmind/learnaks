resource "azurerm_container_registry" "acr" {
  name                = "${var.cluster_name}ContainerRegistry"
  resource_group_name = azurerm_resource_group.learn_aks.name
  location            = azurerm_resource_group.learn_aks.location
  sku                 = "Premium"
  admin_enabled       = false
}

# user for azure container registry
resource "azuread_service_principal" "acr" {
  application_id = azuread_application.learn_aks.application_id
}

resource "random_string" "password_acr" {
  length           = 16
  special          = true
  override_special = "/@\" "
}

resource "azuread_service_principal_password" "acr" {
  service_principal_id = azuread_service_principal.acr.id
  value                = random_string.password_acr.result
  end_date_relative    = "240h"
}

resource "azurerm_role_assignment" "acr" {
  scope                = "${data.azurerm_subscription.primary.id}/resourcegroups/${azurerm_resource_group.learn_aks.name}/providers/Microsoft.ContainerRegistry/registries/${azurerm_container_registry.acr.name}"
  role_definition_name = "Reader"
  principal_id         = azuread_service_principal.acr.id
}

# this is the secret that kubernetes uses to pull images from acr
locals {
  acr_username = azuread_application.learn_aks.application_id
  acr_password = azuread_service_principal_password.acr.value
  acr_server   = "${azurerm_container_registry.acr.name}.azurecr.io"
  acr_dockerconf = {
    "auths" = {
      "${local.acr_server}" = {
        "username" : local.acr_username
        "password" : local.acr_password
        "email" : ""
        "auth" : base64encode("${local.acr_username}:${local.acr_password}")
      }
    }
  }
  acr_image_pull_secret_name = "acr-image-pull-secret"
}

resource "kubernetes_secret" "acr" {
  for_each = toset(local.aks_allnamespaces)

  metadata {
    name      = local.acr_image_pull_secret_name
    namespace = each.key
  }

  data = {
    ".dockerconfigjson" = jsonencode(local.acr_dockerconf)
  }

  type = "kubernetes.io/dockerconfigjson"

  depends_on = [
    kubernetes_namespace.additional_namespaces
  ]
}

