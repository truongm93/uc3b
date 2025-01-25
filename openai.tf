resource "azurerm_cognitive_account" "this" {
  name                = format("uc3bopenai%s", random_string.this.result)
  location            = var.location
  resource_group_name = var.rg_name
  kind                = "OpenAI"
  public_network_access_enabled = var.public_network_access_enabled

  sku_name = "S0"

  depends_on = [ azurerm_resource_group.this ]
}