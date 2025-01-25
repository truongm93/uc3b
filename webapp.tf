resource "azurerm_service_plan" "this" {
  name                = format("uc3bserviceplan%s", random_string.this.result)
  resource_group_name = var.rg_name
  location            = var.location
  sku_name            = "S1"
  os_type             = "Windows"

  depends_on = [ azurerm_resource_group.this ]
}

resource "azurerm_windows_web_app" "this" {
  name                = format("uc3bwebapp%s", random_string.this.result)
  resource_group_name = var.rg_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.this.id
  public_network_access_enabled = var.public_network_access_enabled

  site_config {}

  depends_on = [ azurerm_resource_group.this, azurerm_service_plan.this ]
}