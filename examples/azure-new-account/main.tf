provider "volterra" {
  api_p12_file = var.xc_api_p12_file
  url          = var.xc_api_url
}

provider "azurerm" {
  features {}
  skip_provider_registration = "true"

  subscription_id   = var.azure_subscription_id
  tenant_id         = var.azure_tenant_id
}

provider "azuread" {
  tenant_id = var.azure_tenant_id
}

module "azure_cloud_credentials" {
  source            = "../.."

  name              = "azure-tf-demo-creds"
  end_date_relative = "10h"
}
