/*output "image_id" {
  value = "/subscriptions/3dc3cd1a-d5cd-4e3e-a648-b2253048af83/resourceGroups/ranjith/providers/Microsoft.Compute/images/my-image"
}*/

data "azurerm_image" "img"{
  name = "myPackerImage"
  resource_group_name = "ranjith"
}

output "image_id" {
  value = "/subscriptions/3dc3cd1a-d5cd-4e3e-a648-b2253048af83/resourceGroups/ranjith/providers/Microsoft.Compute/images/myPackerImage"
}

output "image_id1" {
  value = data.azurerm_image.img.id
}