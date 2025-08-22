# Azure Existing Account Example

This example demonstrates how to use the Azure Cloud Credentials module with existing Azure Service Principal credentials to register them with F5 Distributed Cloud (XC).

## What this example does

- Uses your existing Azure Service Principal credentials
- Registers the existing credentials with F5 Distributed Cloud
- Does not create any new Azure resources

## Prerequisites

- Existing Azure Service Principal with appropriate permissions
- F5 Distributed Cloud account and API certificate  
- Terraform >= 1.0

## Usage

1. Set your Azure credentials:
   ```bash
   export ARM_SUBSCRIPTION_ID="your-azure-subscription-id"
   export ARM_TENANT_ID="your-azure-tenant-id"
   export ARM_CLIENT_ID="your-service-principal-client-id"
   export ARM_CLIENT_SECRET="your-service-principal-secret"
   ```

2. Create a `terraform.tfvars` file:
   ```hcl
   azure_subscription_id = "your-azure-subscription-id"
   azure_tenant_id       = "your-azure-tenant-id"
   azure_client_id       = "your-existing-service-principal-client-id"
   azure_client_secret   = "your-existing-service-principal-secret"
   xc_api_p12_file      = "./path/to/your-api-cert.p12"
   xc_api_url           = "https://your-tenant.console.ves.volterra.io/api"
   ```

3. Initialize and apply:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

## Inputs

| Name                  | Description                                     | Type     | Default                                                       | Required |
| --------------------- | ----------------------------------------------- | -------- | ------------------------------------------------------------- | :------: |
| azure_subscription_id | Existing Azure Subscription ID                  | `string` | `null`                                                        |   yes    |
| azure_tenant_id       | Existing Azure Tenant ID                        | `string` | `null`                                                        |   yes    |
| azure_client_id       | Existing Azure Service Principal Application ID | `string` | `null`                                                        |   yes    |
| azure_client_secret   | Existing Azure Service Principal Password       | `string` | `null`                                                        |   yes    |
| xc_api_p12_file       | Path to F5 XC Cloud API certificate             | `string` | `"./api-certificate.p12"`                                     |   yes    |
| xc_api_url            | F5 XC Cloud API URL                             | `string` | `"https://your_xc-cloud_api_url.console.ves.volterra.io/api"` |   yes    |

## Outputs

The module will output the provided Azure credentials and the F5 XC Cloud Credentials object details.

## Notes

- This example does not create any new Azure resources
- Ensure your existing Service Principal has the required permissions for F5 XC operations
- The Service Principal credentials are passed through to F5 XC securely
