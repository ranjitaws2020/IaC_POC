#  Create a Resource Group for the new Virtual Machine.
 data "azurerm_resource_group" "main" {
   name     = "Ranjith"
   # location = "eastus"
 }

#  Locate the existing shared image
 data "azurerm_shared_image" "asig-vm" {
  name          = "my-image"
  gallery_name        = "packer_image_gallery"
  resource_group_name = data.azurerm_resource_group.main.name

  depends_on = [
    azurerm_shared_image_gallery.sig,
    azurerm_shared_image.si
   ]
 }

#  Create a Subnet within the Virtual Network

 data "azurerm_virtual_network" "vnet"{
   name = "ranjith-vnet"
   resource_group_name  = data.azurerm_resource_group.main.name
   # location = "eastus"
 }

 resource "azurerm_subnet" "internal" {
   name                 = "RG-Terraform-snet-in"
   virtual_network_name = data.azurerm_virtual_network.vnet.name
   resource_group_name  = data.azurerm_resource_group.main.name
   address_prefixes       = ["10.0.2.0/24"]
 }

#  Create a Network Security Group with some rules
 resource "azurerm_network_security_group" "nsg" {
   name                = "RG-QA-Test-Dev-NSG"
   location            = data.azurerm_resource_group.main.location
   resource_group_name = data.azurerm_resource_group.main.name

   security_rule {
     name                       = "allow_SSH"
     description                = "Allow SSH access"
     priority                   = 100
     direction                  = "Inbound"
     access                     = "Allow"
     protocol                   = "Tcp"
     source_port_range          = "*"
     destination_port_range     = "22"
     source_address_prefix      = "*"
     destination_address_prefix = "*"
   }
 }

#  Create a network interface for VMs and attach the PIP and the NSG
 resource "azurerm_network_interface" "nic" {
   name                      = "NIC"
   location                  = data.azurerm_resource_group.main.location
   resource_group_name       = data.azurerm_resource_group.main.name
   
   ip_configuration {
     name                          = "nicconfig"
     subnet_id                     = azurerm_subnet.internal.id
     private_ip_address_allocation = "Dynamic"
     #private_ip_address            = cidrhost("10.100.2.16/24", 4)
   }
 }

resource "azurerm_windows_virtual_machine" "vm-img" {
  name                = "vm-image"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_id =  data.azurerm_shared_image.asig-vm.id
    
  /*source_image_reference {
    pubpublisher = data.azurerm_shared_image_versions.asig.publisher
    offer = data.azurerm_shared_image_versions.asig.offer
    sku = data.azurerm_shared_image_versions.asig.sku
    version = data.azurerm_shared_image_versions.asig.version.latest
  }*/
}

/*
#  Create a new Virtual Machine based on the Golden Image
 resource "azurerm_virtual_machine" "vm" {
   name                             = "AZLXDEVOPS01"
   location                         = azurerm_resource_group.main.location
   resource_group_name              = azurerm_resource_group.main.name
   network_interface_ids            = [azurerm_network_interface.main.id]
   vm_size                          = "Standard_DS12_v2"
   delete_os_disk_on_termination    = true
   delete_data_disks_on_termination = true

   
   storage_image_reference {
     id = data.azurerm_image.search.id
   }*

   storage_os_disk {
     name              = "AZLXDEVOPS01-OS"
     caching           = "ReadWrite"
     create_option     = "FromImage"
     managed_disk_type = "Standard_LRS"
 }

   os_profile {
     computer_name  = "APPVM"
     admin_username = "devopsadmin"
     admin_password = "Cssladmin2019"
   }  
 }*/