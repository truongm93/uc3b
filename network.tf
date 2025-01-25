## NSG
resource "azurerm_network_security_group" "this" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.rg_name
  
  depends_on = [ azurerm_resource_group.this ]
}

## Vnet Jumpbox
resource "azurerm_virtual_network" "jumpbox-vnet" {
  name                = var.jumpbox_vnet_name
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = ["10.0.0.0/16"]

  depends_on = [ azurerm_resource_group.this ]
}

## Subnet Jumpbox
resource "azurerm_subnet" "jumpbox" {
  name                 = "jumpbox-subnet"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.jumpbox-vnet.name
  address_prefixes     = ["10.0.0.0/28"]

  depends_on = [ azurerm_resource_group.this, azurerm_virtual_network.jumpbox-vnet ]
}

## Vnet AI Zone
resource "azurerm_virtual_network" "ai-zone" {
  name                = "UC3B-openai-sentiment-vnet"
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = ["10.1.0.0/16"]

  depends_on = [azurerm_resource_group.this ]
}

resource "azurerm_subnet" "pe" {
  name                 = "pe-subnet"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.ai-zone.name
  address_prefixes     = ["10.1.0.0/24"]

  depends_on = [ azurerm_resource_group.this, azurerm_virtual_network.ai-zone ]
}

## Vnet Peering
resource "azurerm_virtual_network_peering" "peer-1" {
  name                      = "peer1to2"
  resource_group_name       = var.rg_name
  virtual_network_name      = azurerm_virtual_network.jumpbox-vnet.name
  remote_virtual_network_id = azurerm_virtual_network.ai-zone.id

  depends_on = [ azurerm_resource_group.this, azurerm_virtual_network.ai-zone, azurerm_virtual_network.jumpbox-vnet ]
}

resource "azurerm_virtual_network_peering" "peer-2" {
  name                      = "peer2to1"
  resource_group_name       = var.rg_name
  virtual_network_name      = azurerm_virtual_network.ai-zone.name
  remote_virtual_network_id = azurerm_virtual_network.jumpbox-vnet.id

  depends_on = [ azurerm_resource_group.this, azurerm_virtual_network.ai-zone, azurerm_virtual_network.jumpbox-vnet ]
}

