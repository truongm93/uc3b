variable "subscription_id" {
  description = "The subscription ID"
  type        = string
  
}

variable "rg_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location for the ressources"
  type        = string
}

variable "public_network_access_enabled" {
  description = "Enable or disable public network access"
  type        = bool
}

## Network
variable "nsg_name" {
  description = "The name of the network security group"
  type        = string
}

variable "jumpbox_vnet_name" {
  description = "The name of the Jumpbox virtual network"
  type        = string
  
}