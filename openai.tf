resource "azurerm_cognitive_account" "this" {
  name                = format("uc3bopenai%s", random_string.this.result)
  location            = var.location
  resource_group_name = var.rg_name
  kind                = "OpenAI"
  public_network_access_enabled = var.public_network_access_enabled
  sku_name = "S0"
  identity {
    type = "SystemAssigned"
  }

  depends_on = [ azurerm_resource_group.this ]
}

resource "azurerm_role_assignment" "searchcontrib" {
  scope                = azurerm_resource_group.this.id
  role_definition_name = "Search Service Contributor"
  principal_id         = azurerm_cognitive_account.this.identity[0].principal_id

  depends_on = [ azurerm_resource_group.this, azurerm_cognitive_account.this ]
}

resource "azurerm_role_assignment" "searchreader" {
  scope                = azurerm_resource_group.this.id
  role_definition_name = "Search Index Data Reader"
  principal_id         = azurerm_cognitive_account.this.identity[0].principal_id

  depends_on = [ azurerm_resource_group.this, azurerm_cognitive_account.this ]
}

resource "azurerm_role_assignment" "blob" {
  scope                = azurerm_resource_group.this.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_cognitive_account.this.identity[0].principal_id

  depends_on = [ azurerm_resource_group.this, azurerm_cognitive_account.this ]
}