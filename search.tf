resource "azurerm_search_service" "this" {
  name                = format("uc3bsearchg%s", random_string.this.result)
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = "standard"
  public_network_access_enabled = var.public_network_access_enabled

  depends_on = [ azurerm_resource_group.this ]
}