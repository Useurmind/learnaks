# the root resource group for our azure stuff

resource "azurerm_resource_group" "learn_aks" {
  name     = "${var.cluster_name}RG"
  location = var.location
}
