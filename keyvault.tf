data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "example" {
  name                        = format("uc3bkv%s", random_string.this.result)
  location                    = var.location
  resource_group_name         = var.rg_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  public_network_access_enabled = var.public_network_access_enabled

  sku_name = "standard"

  depends_on = [ azurerm_resource_group.this ]
}