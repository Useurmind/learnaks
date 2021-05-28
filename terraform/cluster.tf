# the root resource group for our azure stuff

resource "azurerm_resource_group" "learn_aks" {
  name     = "learnaks"
  location = "west europe"
}
