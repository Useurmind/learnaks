variable vnet_cidr {
  default = "10.0.0.0/8"
}

variable subnet_gateway_cidr {
  default = "10.0.1.0/24"
}

variable subnet_aks_cidr {
  default = "10.1.0.0/16"
}

resource "azurerm_virtual_network" "learn_aks_net" {
  name                = "learn_aks_net"
  location            = azurerm_resource_group.learn_aks.location
  resource_group_name = azurerm_resource_group.learn_aks.name
  address_space       = [var.vnet_cidr]
  # dns_servers         = ["10.0.0.4", "10.0.0.5"]
}

resource "azurerm_subnet" "app_gw" {
  name                 = "sub_app_gw"
  resource_group_name  = azurerm_resource_group.learn_aks.name
  virtual_network_name = azurerm_virtual_network.learn_aks_net.name
  address_prefixes     = [var.subnet_gateway_cidr]
}

resource "azurerm_subnet" "aks" {
  name                 = "sub_aks"
  resource_group_name  = azurerm_resource_group.learn_aks.name
  virtual_network_name = azurerm_virtual_network.learn_aks_net.name
  address_prefixes     = [var.subnet_aks_cidr]
}