# Azure New Account Example

This example demonstrates how to use the Azure Cloud Credentials module to create a new Azure Service Principal and register it with F5 Distributed Cloud (XC).

## What this example does

- Creates a new Azure Service Principal with the required permissions
- Creates an Azure Role Definition with F5 XC-specific permissions
- Registers the Service Principal credentials with F5 Distributed Cloud

## Prerequisites

- Azure subscription with appropriate permissions to create Service Principals and Role Definitions
- F5 Distributed Cloud account and API certificate
- Terraform >= 1.0

## Usage

1. Set your Azure credentials:
   ```bash
   export ARM_SUBSCRIPTION_ID="your-azure-subscription-id"
   export ARM_TENANT_ID="your-azure-tenant-id"
   export ARM_CLIENT_ID="your-service-principal-client-id"  # Optional if using Azure CLI
   export ARM_CLIENT_SECRET="your-service-principal-secret"  # Optional if using Azure CLI
   ```

2. Create a `terraform.tfvars` file:
   ```hcl
   azure_subscription_id = "your-azure-subscription-id"
   azure_tenant_id       = "your-azure-tenant-id"
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

| Name                  | Description                         | Type     | Default                                                       | Required |
| --------------------- | ----------------------------------- | -------- | ------------------------------------------------------------- | :------: |
| azure_subscription_id | Azure Subscription ID               | `string` | `null`                                                        |   yes    |
| azure_tenant_id       | Azure Tenant ID                     | `string` | `null`                                                        |   yes    |
| xc_api_p12_file       | Path to F5 XC Cloud API certificate | `string` | `"./api-certificate.p12"`                                     |   yes    |
| xc_api_url            | F5 XC Cloud API URL                 | `string` | `"https://your_xc-cloud_api_url.console.ves.volterra.io/api"` |   yes    |

## Outputs

The module will output the created Service Principal credentials (marked as sensitive) and the F5 XC Cloud Credentials object details.

## Notes

- The Service Principal password is set to expire in 10 days (240 hours) in this example
- All Azure resources will be created in your specified subscription
- The created Service Principal will have the minimum required permissions for F5 XC VNET site creation
