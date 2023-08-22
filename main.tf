provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "aks_rg" {
  name     = "myaksresourcegroup"
  location = "East US"  # Update with your desired region
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "my-aks-cluster"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "myakscluster"  # Update with your desired DNS prefix

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"  # Update with your desired VM size
  }

  tags = {
    environment = "dev"
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }
}
