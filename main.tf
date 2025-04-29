provider "azurerm" {
  features {}
  subscription_id = "d39add2e-a062-4ac2-b217-b69b4fb14a19"
}
resource "azurerm_resource_group" "example" {
  for_each = toset(["rg220401", "rg220404", "rg220403"])
  name     = "resourceGroup-${each.value}"
  location = "East US"
}

resource "azurerm_storage_account" "example" {
  for_each = {
    rg220401 = "eastus2"
    rg220404 = "westus"
    rg220403 = "centralus"
  }
  name                     = "storage${each.key}"
  resource_group_name      = azurerm_resource_group.example[each.key].name
  location                 = each.value
  account_tier             = "General Purpose"
  account_replication_type = "GRS"
}

