resource "azurerm_network_interface" "nic" {
    name = var.nic_name
    resource_group_name = var.resource_group_name
    location = var.location
    ip_configuration {
        name = var.ip_configuration_name
        subnet_id = data.azurerm_subnet.subnet.id
        public_ip_address_id = data.azurerm_public_ip.pip.id
        private_ip_address_allocation = "Dynamic"
    }
}


