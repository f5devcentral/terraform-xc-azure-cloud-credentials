# Azure Cloud Credentials for F5 Distributed Cloud (XC) Terraform module

This Terraform module provisions Azure Cloud Credentials in F5 Distributed Cloud (XC). It creates an Azure Service Principal, Application, Role Definition with required permissions, along with a Cloud Credentials object in XC Cloud.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](https://github.com/hashicorp/terraform) | >= 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs) | >= 3.0 |
| <a name="requirement_azuread"></a> [azuread](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs) | >= 2.0 |
| <a name="requirement_volterra"></a> [volterra](https://registry.terraform.io/providers/volterraedge/volterra/latest) | >= 0.11.26 |

## Usage

To use this module and leverage your existing credentials without provisioning any resources on Azure Cloud, include the following code in your Terraform configuration:

```hcl
module "azure_cloud_credentials" {
  source  = "f5devcentral/azure-cloud-credentials/xc"
  version = "0.0.6"

  name                  = "azure-tf-demo-creds"
  azure_subscription_id = "your_azure_subscription_id"
  azure_tenant_id       = "your_azure_tenant_id"
  azure_client_id       = "your_azure_client_id"
  azure_client_secret   = "your_azure_client_secret"
}
```

If you want to create a new Azure Service Principal

```hcl
module "azure_cloud_credentials" {
  source  = "f5devcentral/azure-cloud-credentials/xc"
  version = "0.0.6"

  name              = "azure-tf-demo-creds"
  create_sa         = true
  end_date_relative = "10d"
}
```

## Contributing

Contributions to this module are welcome! Please see the contribution guidelines for more information.

## License

This module is licensed under the Apache 2.0 License.