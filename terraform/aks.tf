
variable aks_docker_bridge_cidr {
  default =  "172.17.0.1/16"
}

variable aks_dns_service_ip {
  default =  "172.16.0.5"
}

variable aks_service_cidr {
  default =  "172.16.0.0/16"
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name                = "k8s"
  location            = azurerm_resource_group.learn_aks.location
  resource_group_name = azurerm_resource_group.learn_aks.name
  dns_prefix          = "joglearnaks"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
    vnet_subnet_id = azurerm_subnet.aks.id
  }

  network_profile {
      network_plugin = "azure"
      docker_bridge_cidr = var.aks_docker_bridge_cidr
      dns_service_ip = var.aks_dns_service_ip
      service_cidr = var.aks_service_cidr
  }

  identity {
    type = "SystemAssigned"
  }

  addon_profile {
    ingress_application_gateway {
        enabled = true
        subnet_id = azurerm_subnet.app_gw.id
    }

    oms_agent {
      enabled = true
      log_analytics_workspace_id = azurerm_log_analytics_workspace.learnaks.id
    }
  }

  role_based_access_control {
    enabled = true
    azure_active_directory {
      managed = true
      tenant_id = data.azuread_client_config.current.tenant_id
      admin_group_object_ids = [azuread_group.aks_admin.id]
    }
  }
}
