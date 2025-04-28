provider "azurerm" {
  features {}
  subscription_id = "d39add2e-a062-4ac2-b217-b69b4fb14a19"
}
resource "azurerm_resource_group" "example" {
  for_each = toset(["rg2204_01", "rg2204_02", "rg2204_03"])
  name     = "resourceGroup-${each.value}"
  location = "East US"
}

resource "azurerm_storage_account" "example" {
  for_each = {
    rg2204_01 = "eastus2"
    rg2204_02 = "westus"
    rg2204_03 = "centralus"
  }
  name                     = "storage${each.key}"
  resource_group_name      = azurerm_resource_group.example[each.key].name
  location                 = each.value
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

