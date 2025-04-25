provider "azurerm" {
  features {}
  subscription_id = "d39add2e-a062-4ac2-b217-b69b4fb14a19"
}
resource "azurerm_resource_group" "example" {
  for_each = toset(["abc", "xyz", "pqr"])
  name     = "resourceGroup-${each.value}"
  location = "East US"
}

resource "azurerm_storage_account" "example" {
  for_each = {
    abc = "eastus2"
    xyz = "westus"
    pqr = "centralus"
  }
  name                     = "storage${each.key}"
  resource_group_name      = azurerm_resource_group.example[each.key].name
  location                 = each.value
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

