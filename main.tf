data "azuread_client_config" "current" {}

data "azurerm_subscription" "primary" {}

locals {
  # Compute an absolute end date for the SP password.
  # Use explicit end_date if provided; otherwise, default to one year from now.
  sp_password_end_date = var.end_date != null ? var.end_date : timeadd(timestamp(), "8766h")
}

resource "azurerm_role_definition" "this" {
  count = var.create_sa ? 1 : 0

  name        = var.name
  scope       = data.azurerm_subscription.primary.id
  description = "F5 XC Custom Role to create Azure VNET site"

  permissions {
    actions = [
      "*/read",
      "*/register/action",
      "Microsoft.Compute/disks/delete",
      "Microsoft.Compute/skus/read",
      "Microsoft.Compute/virtualMachineScaleSets/delete",
      "Microsoft.Compute/virtualMachineScaleSets/write",
      "Microsoft.Compute/virtualMachines/delete",
      "Microsoft.Compute/virtualMachines/write",
      "Microsoft.MarketplaceOrdering/agreements/offers/plans/cancel/action",
      "Microsoft.MarketplaceOrdering/offerTypes/publishers/offers/plans/agreements/write",
      "Microsoft.Network/loadBalancers/backendAddressPools/delete",
      "Microsoft.Network/loadBalancers/backendAddressPools/join/action",
      "Microsoft.Network/loadBalancers/backendAddressPools/write",
      "Microsoft.Network/loadBalancers/delete",
      "Microsoft.Network/loadBalancers/write",
      "Microsoft.Network/locations/setLoadBalancerFrontendPublicIpAddresses/action",
      "Microsoft.Network/networkInterfaces/delete",
      "Microsoft.Network/networkInterfaces/join/action",
      "Microsoft.Network/networkInterfaces/write",
      "Microsoft.Network/networkSecurityGroups/delete",
      "Microsoft.Network/networkSecurityGroups/join/action",
      "Microsoft.Network/networkSecurityGroups/securityRules/delete",
      "Microsoft.Network/networkSecurityGroups/securityRules/write",
      "Microsoft.Network/networkSecurityGroups/write",
      "Microsoft.Network/publicIPAddresses/delete",
      "Microsoft.Network/publicIPAddresses/join/action",
      "Microsoft.Network/publicIPAddresses/write",
      "Microsoft.Network/routeTables/delete",
      "Microsoft.Network/routeTables/join/action",
      "Microsoft.Network/routeTables/write",
      "Microsoft.Network/routeTables/routes/delete",
      "Microsoft.Network/routeTables/routes/write",
      "Microsoft.Network/virtualHubs/delete",
      "Microsoft.Network/virtualHubs/bgpConnections/delete",
      "Microsoft.Network/virtualHubs/bgpConnections/read",
      "Microsoft.Network/virtualHubs/bgpConnections/write",
      "Microsoft.Network/virtualHubs/ipConfigurations/delete",
      "Microsoft.Network/virtualHubs/ipConfigurations/read",
      "Microsoft.Network/virtualHubs/ipConfigurations/write",
      "Microsoft.Network/virtualHubs/read",
      "Microsoft.Network/virtualHubs/write",
      "Microsoft.Network/virtualNetworks/delete",
      "Microsoft.Network/virtualNetworks/peer/action",
      "Microsoft.Network/virtualNetworks/subnets/delete",
      "Microsoft.Network/virtualNetworks/subnets/join/action",
      "Microsoft.Network/virtualNetworks/subnets/read",
      "Microsoft.Network/virtualNetworks/subnets/write",
      "Microsoft.Network/virtualNetworks/virtualNetworkPeerings/write",
      "Microsoft.Network/virtualNetworks/virtualNetworkPeerings/delete",
      "Microsoft.Network/virtualNetworks/write",
      "Microsoft.Network/virtualNetworkGateways/delete",
      "Microsoft.Network/virtualNetworkGateways/read",
      "Microsoft.Network/virtualNetworkGateways/write",
      "Microsoft.Resources/subscriptions/locations/read",
      "Microsoft.Resources/subscriptions/resourcegroups/delete",
      "Microsoft.Resources/subscriptions/resourcegroups/read",
      "Microsoft.Resources/subscriptions/resourcegroups/write",
      "Microsoft.Compute/virtualMachines/extensions/write",
      "Microsoft.Compute/virtualMachines/extensions/delete"
    ]
    not_actions = []
  }

  assignable_scopes = [
    data.azurerm_subscription.primary.id
  ]
}

resource "azuread_application" "this" {
  count = var.create_sa ? 1 : 0

  display_name = var.name
  owners = [
    data.azuread_client_config.current.object_id,
  ]
  tags = values(var.tags)
}

resource "azuread_service_principal" "this" {
  count = var.create_sa ? 1 : 0

  client_id = azuread_application.this[0].client_id
  owners = [
    data.azuread_client_config.current.object_id,
  ]
}

resource "azuread_service_principal_password" "this" {
  count = var.create_sa ? 1 : 0

  service_principal_id = azuread_service_principal.this[0].id
  end_date             = local.sp_password_end_date
}

resource "azurerm_role_assignment" "this" {
  count = var.create_sa ? 1 : 0

  scope              = data.azurerm_subscription.primary.id
  role_definition_id = azurerm_role_definition.this[0].role_definition_resource_id
  principal_id       = azuread_service_principal.this[0].object_id
}

resource "volterra_cloud_credentials" "this" {
  name      = var.name
  namespace = "system"
  azure_client_secret {
    client_id = var.create_sa ? azuread_application.this[0].client_id : var.azure_client_id
    client_secret {
      clear_secret_info {
        url = "string:///${base64encode(var.create_sa ? azuread_service_principal_password.this[0].value : var.azure_client_secret)}"
      }
    }
    subscription_id = var.create_sa ? replace(data.azurerm_subscription.primary.id, "//subscriptions//", "") : var.azure_subscription_id
    tenant_id       = var.create_sa ? data.azuread_client_config.current.tenant_id : var.azure_tenant_id
  }
}
