# this script configures the required aad groups and role assignments for the interaction with aks
#
# - admin: the aks admin that can administrate everything in the cluster
# - developer: the aks developer that can also do everything in the cluster but has permissions via a separate ClusterRole
# - viewer: the aks viewer that can only view everything in the cluster
#
# the actual permissions are not in here but in the helm chart folder aks_permissions

locals {
  aad_group_prefix = "${var.cluster_name}-"
}

data "azuread_client_config" "current" {
}

resource "azuread_group" "aks_admin" {
  display_name            = "${local.aad_group_prefix}admin"
  prevent_duplicate_names = true
}

resource "azuread_group" "aks_developer" {
  display_name            = "${local.aad_group_prefix}developer"
  prevent_duplicate_names = true
}

resource "azurerm_role_assignment" "aks_developer" {
  scope                = azurerm_kubernetes_cluster.k8s.id
  role_definition_name = "Azure Kubernetes Service Cluster User Role"
  principal_id         = azuread_group.aks_developer.object_id
}

resource "azuread_group" "aks_viewer" {
  display_name            = "${local.aad_group_prefix}viewer"
  prevent_duplicate_names = true
}

resource "azurerm_role_assignment" "aks_viewer" {
  scope                = azurerm_kubernetes_cluster.k8s.id
  role_definition_name = "Azure Kubernetes Service Cluster User Role"
  principal_id         = azuread_group.aks_viewer.object_id
}

resource "azuread_application" "learn_aks" {
  display_name = var.cluster_name
}
