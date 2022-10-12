data "azurerm_resource_group" "rg" {
  name     = "ranjith"
  #location = "eastus"
}

resource "azurerm_shared_image_gallery" "sig" {
  name                = "packer_image_gallery"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  description         = "Shared images and things."

  tags = {
    Hello = "There"
    World = "Example"
  }
}

resource "azurerm_shared_image" "si" {
  name                = "my-image"
  gallery_name        = azurerm_shared_image_gallery.sig.name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  os_type             = "Linux"

  identifier {
    publisher = "PublisherName"
    offer     = "OfferName"
    sku       = "ExampleSku"
  }
}