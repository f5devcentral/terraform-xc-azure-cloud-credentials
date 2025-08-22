# Azure Cloud Credentials for F5 Distributed Cloud (XC) Terraform module

This Terraform module provisions Azure Cloud Credentials in F5 Distributed Cloud (XC). It creates an Azure Service Principal, Application, Role Definition with required permissions, along with a Cloud Credentials object in XC Cloud.

> **Note**: This module is developed and maintained by the [F5 DevCentral](https://github.com/f5devcentral) community. You can use this module as an example for your own development projects.

## Requirements

| Name                                                                                                                 | Version   |
| -------------------------------------------------------------------------------------------------------------------- | --------- |
| <a name="requirement_terraform"></a> [terraform](https://github.com/hashicorp/terraform)                             | >= 1.0    |
| <a name="requirement_azurerm"></a> [azurerm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)  | >= 4.39.0 |
| <a name="requirement_azuread"></a> [azuread](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs)  | >= 3.5.0  |
| <a name="requirement_volterra"></a> [volterra](https://registry.terraform.io/providers/volterraedge/volterra/latest) | = 0.11.44 |

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

  name      = "azure-tf-demo-creds"
  create_sa = true
  # Set an absolute end date for the password. Example below sets it to 10 days from now.
  end_date  = timeadd(timestamp(), "240h")
}
```

## Inputs

| Name                  | Description                                                                                                                                                                        | Type          | Default |
| --------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------- | ------- |
| name                  | Cloud Credentials name                                                                                                                                                             | `string`      | `""`    |
| create_sa             | Create a new Service Principal                                                                                                                                                     | `bool`        | `false` |
| azure_subscription_id | Existing Azure Subscription ID                                                                                                                                                     | `string`      | `null`  |
| azure_tenant_id       | Existing Azure Tenant ID                                                                                                                                                           | `string`      | `null`  |
| azure_client_id       | Existing Azure Service Principal Application ID                                                                                                                                    | `string`      | `null`  |
| azure_client_secret   | Existing Azure Service Principal Password                                                                                                                                          | `string`      | `null`  |
| end_date              | The absolute end date until which the password is valid, formatted as an RFC3339 date string (e.g. 2218-01-01T01:02:03Z). Changing this field forces a new resource to be created. | `string`      | `null`  |
| tags                  | A map of tags to add to all resources                                                                                                                                              | `map(string)` | `{}`    |

## Outputs

| Name                              | Description                                                |
| --------------------------------- | ---------------------------------------------------------- |
| azure_subscription_id             | Azure Subscription ID                                      |
| azure_tenant_id                   | Azure Tenant ID                                            |
| azure_client_id                   | Created Azure Service Principal Application ID             |
| azure_client_secret               | Created Azure Service Principal Password                   |
| azure_role_definition_resource_id | Created Azure Role Definition Resource ID                  |
| azure_service_principal_id        | Created Azure Service Principal ID                         |
| name                              | Created XC Cloud Credentials name                          |
| namespace                         | The namespace in which the XC Cloud Credentials is created |
| id                                | ID of the created XC Cloud Credentials                     |

## Contributing

Contributions to this module are welcome! Please see the contribution guidelines for more information.

## License

This module is licensed under the Apache 2.0 License.