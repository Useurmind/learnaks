variable location {
    description = "The azure region to deploy to"
    default = "west europe"
}

variable cluster_name {
    description = "Common name used for many resources in the cluster, must be globally unique."
    default = "joglearnaks"
}

variable log_storage_account_rg {
    description = "Name of the resource group of the storage account for logging and monitoring"
}

variable log_storage_account_name {
    description = "Name of the storage account for logging and monitoring"
}