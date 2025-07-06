resource "azurerm_key_vault_secret" "secret" {
  name         = var.secret_name
  value        = var.secret_value
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault" "kv" {
    name = var.kv_name
    resource_group_name = var.resource_group_name
}

variable "secret_name" {
  type = string
}
variable "secret_value" {
  type = string
}
variable "kv_name" {
  type = string
}
variable "resource_group_name" {
  type = string
}