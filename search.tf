resource "azurerm_search_service" "this" {
  name                = format("uc3bsearchg%s", random_string.this.result)
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = "standard"
  public_network_access_enabled = var.public_network_access_enabled
  local_authentication_enabled = true
  authentication_failure_mode  = "http403"
  identity {
    type = "SystemAssigned"
  }

  depends_on = [ azurerm_resource_group.this ]
}

resource "azurerm_role_assignment" "aicontrib" {
  scope                = azurerm_resource_group.this.id
  role_definition_name = "Cognitive Services OpenAI Contributor"
  principal_id         = azurerm_search_service.this.identity[0].principal_id

  depends_on = [ azurerm_resource_group.this, azurerm_search_service.this ]
}


resource "azurerm_role_assignment" "searchblob" {
  scope                = azurerm_resource_group.this.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = azurerm_search_service.this.identity[0].principal_id

  depends_on = [ azurerm_resource_group.this, azurerm_search_service.this ]
}