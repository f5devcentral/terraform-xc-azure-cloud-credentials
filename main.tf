locals {
  create_sa = var.azure_subscription_id == null || var.azure_tenant_id == null || var.azure_client_secret == null || var.azure_client_id == null
}

data "azuread_client_config" "current" {}

data "azurerm_subscription" "primary" {}

resource "azurerm_role_definition" "this" {
  count       = local.create_sa ? 1 : 0

  name        = var.name
  scope       = data.azurerm_subscription.primary.id
  description = "F5 XC Custom Role to create Azure VNET site"

  permissions {
    actions = [
      "*/read",
      "*/register/action",
      "Microsoft.Authorization/roleAssignments/*",
      "Microsoft.Compute/disks/delete",
      "Microsoft.Compute/virtualMachineScaleSets/delete",
      "Microsoft.Compute/virtualMachineScaleSets/write",
      "Microsoft.Compute/virtualMachines/delete",
      "Microsoft.Compute/virtualMachines/write",
      "Microsoft.Marketplace/offerTypes/publishers/offers/plans/agreements/*",
      "Microsoft.MarketplaceOrdering/agreements/offers/plans/cancel/action",
      "Microsoft.MarketplaceOrdering/offerTypes/publishers/offers/plans/agreements/write",
      "Microsoft.Network/loadBalancers/*",
      "Microsoft.Network/locations/setLoadBalancerFrontendPublicIpAddresses/action",
      "Microsoft.Network/networkInterfaces/*",
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
      "Microsoft.Network/routeTables/routes/write",
      "Microsoft.Network/routeTables/routes/delete",
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
      "Microsoft.Network/virtualNetworks/subnets/*",
      "Microsoft.Network/virtualNetworks/virtualNetworkPeerings/write",
      "Microsoft.Network/virtualNetworks/virtualNetworkPeerings/delete",
      "Microsoft.Network/virtualNetworks/write",
      "Microsoft.Network/virtualNetworkGateways/delete",
      "Microsoft.Network/virtualNetworkGateways/read",
      "Microsoft.Network/virtualNetworkGateways/write",
      "Microsoft.Resources/subscriptions/resourcegroups/*"
    ]
    not_actions = []
  }

  assignable_scopes = [
    data.azurerm_subscription.primary.id
  ]
}

resource "azuread_application" "this" {
  count        = local.create_sa ? 1 : 0

  display_name = var.name
  owners = [
    data.azuread_client_config.current.object_id,
  ]
}

resource "azuread_service_principal" "this" {
  count          = local.create_sa ? 1 : 0

  application_id = azuread_application.this[0].client_id
  owners = [
    data.azuread_client_config.current.object_id,
  ]
}

resource "azuread_service_principal_password" "this" {
  count                = local.create_sa ? 1 : 0

  service_principal_id = azuread_service_principal.this[0].id
  end_date_relative    = var.end_date_relative
  end_date             = var.end_date
}

resource "azurerm_role_assignment" "this" {
  count                = local.create_sa ? 1 : 0

  scope                = data.azurerm_subscription.primary.id
  role_definition_id   = azurerm_role_definition.this[0].role_definition_resource_id
  principal_id         = azuread_service_principal.this[0].id
}

resource "volterra_cloud_credentials" "this" {
  name      = var.name
  namespace = "system"
  azure_client_secret {
    client_id = local.create_sa ? azuread_application.this[0].application_id : var.azure_client_id
    client_secret {
        clear_secret_info {
            url = "string:///${base64encode(local.create_sa ? azuread_service_principal_password.this[0].value : var.azure_client_secret)}"
        }
    }
    subscription_id = local.create_sa ? replace(data.azurerm_subscription.primary.id, "//subscriptions//", "")  : var.azure_subscription_id
    tenant_id       = local.create_sa ? data.azuread_client_config.current.tenant_id : var.azure_tenant_id
  }
}
