data "azurerm_image" "aimg" {
  name                = "myPackerImage"
  resource_group_name = "ranjith"
}

data "azurerm_shared_image" "asig" {
  name                = "my-image"
  gallery_name        = "packer_image_gallery"
  resource_group_name = "ranjith"

  depends_on = [
    azurerm_shared_image_gallery.sig,
    azurerm_shared_image.si
  ]
}

resource "azurerm_shared_image_version" "asigv" {
  name                = "0.0.2"
  gallery_name        = data.azurerm_shared_image.asig.gallery_name
  image_name          = data.azurerm_shared_image.asig.name
  resource_group_name = data.azurerm_shared_image.asig.resource_group_name
  location            = data.azurerm_shared_image.asig.location
  managed_image_id    = data.azurerm_image.aimg.id

  target_region {
    name                   = data.azurerm_shared_image.asig.location
    regional_replica_count = 5
    storage_account_type   = "Standard_LRS"
  }
  depends_on = [
    data.azurerm_image.aimg,
    data.azurerm_shared_image.asig
  ]
}


resource "azurerm_shared_image_version" "asigv1" {
  name                = "0.0.3"
  gallery_name        = data.azurerm_shared_image.asig.gallery_name
  image_name          = data.azurerm_shared_image.asig.name
  resource_group_name = data.azurerm_shared_image.asig.resource_group_name
  location            = data.azurerm_shared_image.asig.location
  managed_image_id    = data.azurerm_image.aimg.id

  target_region {
    name                   = data.azurerm_shared_image.asig.location
    regional_replica_count = 5
    storage_account_type   = "Standard_LRS"
  }
  depends_on = [
    data.azurerm_image.aimg,
    data.azurerm_shared_image.asig
  ]
}