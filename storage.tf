## SA
resource "azurerm_storage_account" "this" {
  name                     = format("uc3bst%s", random_string.this.result)
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  public_network_access_enabled = var.public_network_access_enabled

  depends_on = [ azurerm_resource_group.this ]
}

## PE
resource "azurerm_private_endpoint" "sape" {
  name                = "sa-pe"
  location            = var.location
  resource_group_name = var.rg_name
  subnet_id           = azurerm_subnet.pe.id

  private_service_connection {
    name                           = "sa-privateserviceconnection"
    private_connection_resource_id = azurerm_storage_account.this.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }

## SA DNS
  private_dns_zone_group {
    name                 = "sa-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.sa-dns.id]
  }

  depends_on = [ azurerm_resource_group.this, azurerm_storage_account.this, azurerm_private_dns_zone.sa-dns ]
}

resource "azurerm_private_dns_zone" "sa-dns" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = var.rg_name

  depends_on = [ azurerm_resource_group.this, azurerm_storage_account.this ]
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  name                  = "sa-link"
  resource_group_name   = var.rg_name
  private_dns_zone_name = azurerm_private_dns_zone.sa-dns.name
  virtual_network_id    = azurerm_virtual_network.ai-zone.id

  depends_on = [ azurerm_resource_group.this, azurerm_storage_account.this, azurerm_virtual_network.ai-zone, azurerm_private_dns_zone.sa-dns]
}