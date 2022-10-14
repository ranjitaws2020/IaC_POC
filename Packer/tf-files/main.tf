# # Locate the existing custom/golden image
# data "azurerm_image" "search" {
#   name                = "myPackerImage"
#   resource_group_name = "Ranjith"
# }

# # Create a Resource Group for the new Virtual Machine.
# data "azurerm_resource_group" "main" {
#   name     = "Ranjith"
#   location = "eastus"
# }

# # Create a Subnet within the Virtual Network

# data "azurerm_virtual_network" "vnet"{
#   name = "ranjith-vnet"
#   location = "eastus"
# }

# resource "azurerm_subnet" "internal" {
#   name                 = "RG-Terraform-snet-in"
#   virtual_network_name = azurerm_virtual_network.vnet.name
#   resource_group_name  = azurerm_resource_group.main.name
#   address_prefix       = "10.100.2.0/24"
# }

# # Create a Network Security Group with some rules
# resource "azurerm_network_security_group" "main" {
#   name                = "RG-QA-Test-Dev-NSG"
#   location            = "azurerm_resource_group.main.location"
#   resource_group_name = "azurerm_resource_group.main.name"

#   security_rule {
#     name                       = "allow_SSH"
#     description                = "Allow SSH access"
#     priority                   = 100
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "22"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }
# }

# # Create a network interface for VMs and attach the PIP and the NSG
# resource "azurerm_network_interface" "main" {
#   name                      = "NIC"
#   location                  = azurerm_resource_group.main.location
#   resource_group_name       = azurerm_resource_group.main.name
#   network_security_group_id = azurerm_network_security_group.main.id

#   ip_configuration {
#     name                          = "nicconfig"
#     subnet_id                     = "azurerm_subnet.internal.id"
#     private_ip_address_allocation = "static"
#     private_ip_address            = cidrhost("10.100.2.16/24", 4)
#   }
# }

# # Create a new Virtual Machine based on the Golden Image
# resource "azurerm_virtual_machine" "vm" {
#   name                             = "AZLXDEVOPS01"
#   location                         = azurerm_resource_group.main.location
#   resource_group_name              = azurerm_resource_group.main.name
#   network_interface_ids            = [azurerm_network_interface.main.id]
#   vm_size                          = "Standard_DS12_v2"
#   delete_os_disk_on_termination    = true
#   delete_data_disks_on_termination = true

#   storage_image_reference {
#     id = data.azurerm_image.search.id
#   }

#   storage_os_disk {
#     name              = "AZLXDEVOPS01-OS"
#     caching           = "ReadWrite"
#     create_option     = "FromImage"
#     managed_disk_type = "Standard_LRS"
# }

#   os_profile {
#     computer_name  = "APPVM"
#     admin_username = "devopsadmin"
#     admin_password = "Cssladmin#2019"
#   }

  
# }