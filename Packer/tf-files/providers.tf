# Configure the Microsoft Azure Provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }    
  }
}
provider "azurerm" {
    skip_provider_registration = true
	  subscription_id         = "3dc3cd1a-d5cd-4e3e-a648-b2253048af83"
	  tenant_id               = "7c0c36f5-af83-4c24-8844-9962e0163719"
	  client_id               = "fc7dd0dd-22af-4f9e-a8f0-b17e28f48423"
	  client_secret           = "0TN8Q~dOydUPbocFABPytPy0eWkHGaIk~IN81aU7"

	  features { }
}