module "rg1" {
    source = "../child-module/azurerm_resource_group"
    resource_group_name = "sandy-rg1"
    location = "West Us2"
}