# this script defines the network layout
# it deploys one vnet that we use for everything
# the following subnets are defined
# - gateway: the subnet for the application gateway of the aks cluster
# - aks: the subnet for the aks cluster, DO NOT configure security groups on this vnet, security is defined by aks
# - data: the subnet for data storage

variable "vnet_cidr" {
  default = "10.0.0.0/8"
}

variable "subnet_gateway_cidr" {
  description = "CIDR range for the application gateway subnet. Can be small."
  default     = "10.0.1.0/24"
}

variable "subnet_aks_cidr" {
  description = "CIDR range for the aks cluster subnet. Should be big enough to accomodate all pods with separate ips."
  default     = "10.1.0.0/16"
}

variable "subnet_data_cidr" {
  description = "CIDR range for the data subnet. Should be big enough to accomodate all storage endpoints and hosted services."
  default     = "10.2.0.0/16"
}

resource "azurerm_virtual_network" "learn_aks_net" {
  name                = "${var.cluster_name}-net"
  location            = azurerm_resource_group.learn_aks.location
  resource_group_name = azurerm_resource_group.learn_aks.name
  address_space       = [var.vnet_cidr]
  # dns_servers         = ["10.0.0.4", "10.0.0.5"]
}

resource "azurerm_subnet" "app_gw" {
  name                 = "${var.cluster_name}-subnet-gw"
  resource_group_name  = azurerm_resource_group.learn_aks.name
  virtual_network_name = azurerm_virtual_network.learn_aks_net.name
  address_prefixes     = [var.subnet_gateway_cidr]
}

resource "azurerm_subnet" "aks" {
  name                 = "${var.cluster_name}-subnet-aks"
  resource_group_name  = azurerm_resource_group.learn_aks.name
  virtual_network_name = azurerm_virtual_network.learn_aks_net.name
  address_prefixes     = [var.subnet_aks_cidr]
}

resource "azurerm_subnet" "data" {
  name                 = "${var.cluster_name}-subnet-data"
  resource_group_name  = azurerm_resource_group.learn_aks.name
  virtual_network_name = azurerm_virtual_network.learn_aks_net.name
  address_prefixes     = [var.subnet_data_cidr]
}