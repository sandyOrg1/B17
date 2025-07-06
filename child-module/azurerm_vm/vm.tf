resource "azurerm_linux_virtual_machine" "vm" {
  name = var.vm_name
  resource_group_name = var.resource_group_name
  location = var.location
  size = "Standard_F2"
  admin_username = data.azurerm_key_vault_secret.secret_username.value
  admin_password = data.azurerm_key_vault_secret.secret_password.value
  network_interface_ids = [data.azurerm_network_interface.nic.id]
  disable_password_authentication = false
  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer = "0001-com-ubuntu-server-jammy"
    sku = "22_04-lts"
    version = "latest"
  }
  custom_data = base64encode(<<EOF
#!/bin/bash
apt-get update
apt-get install -y nginx
systemctl enable nginx
systemctl start nginx
EOF
)
}

data "azurerm_network_interface" "nic" {
  name = var.nic_name
  resource_group_name = var.resource_group_name
}
data "azurerm_key_vault" "kv" {
  name = var.kv_name
  resource_group_name = var.resource_group_name
}
data "azurerm_key_vault_secret" "secret_username" {
  name = var.secret_username
  key_vault_id = data.azurerm_key_vault.kv.id
}
data "azurerm_key_vault_secret" "secret_password" {
  name = var.secret_password
  key_vault_id = data.azurerm_key_vault.kv.id
}


variable "vm_name" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}
variable "nic_name" {
  type = string
}
variable "kv_name" {
  type = string
}
variable "secret_username" {
  type = string
}
variable "secret_password" {
  type = string
}

