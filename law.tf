resource "azurerm_log_analytics_workspace" "this" {
  name                = format("uc3blaw%s", random_string.this.result)
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  depends_on = [ azurerm_resource_group.this ]
}

resource "azurerm_application_insights" "this" {
  name                = format("uc3bappinishgts%s", random_string.this.result)
  location            = var.location
  resource_group_name = var.rg_name
  workspace_id        = azurerm_log_analytics_workspace.this.id
  application_type    = "web"

  depends_on = [ azurerm_resource_group.this, azurerm_log_analytics_workspace.this ]
}