# resource "azurerm_powerbi_embedded" "example" {
#   name                = "examplepowerbi"
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name
#   sku_name            = "A1"
#   administrators      = ["azsdktest@microsoft.com"]
# }