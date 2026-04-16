@description('A short prefix used to generate all resource names. 3-10 lowercase alphanumeric characters.')
@minLength(3)
@maxLength(10)
param prefix string

@description('Azure region for all resources. Defaults to West US 2 for demo reliability.')
@allowed([
  'westus2'
  'westus3'
  'eastus2'
  'centralus'
  'northeurope'
  'westeurope'
  'uksouth'
  'australiaeast'
])
param location string = 'westus2'

// ── Resource names derived from prefix ──────────────────────────────────────
var storageAccountName = 'st${toLower(prefix)}${substring(uniqueString(resourceGroup().id), 0, 10)}'
var appInsightsName    = 'appi-${prefix}'
var appServicePlanName = 'asp-${prefix}'
var functionAppName    = 'func-${prefix}'

// ── Storage Account ──────────────────────────────────────────────────────────
resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  sku: { name: 'Standard_LRS' }
  kind: 'StorageV2'
  properties: {
    supportsHttpsTrafficOnly: true
    minimumTlsVersion: 'TLS1_2'
  }
}

// ── Application Insights ─────────────────────────────────────────────────────
resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: appInsightsName
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    Request_Source: 'rest'
  }
}

// ── App Service Plan (Basic B1) ───────────────────────────────────────────────
// Using Basic B1 instead of Consumption/Dynamic (Y1) to avoid the
// "InternalSubscriptionIsOverQuotaForSku / Dynamic VMs" quota error that
// commonly blocks new or trial Azure subscriptions in East US.
// B1 is always-on, predictable, and reliable for demos.
resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'B1'
    tier: 'Basic'
  }
  properties: {
    reserved: true   // required for Linux
  }
}

// ── Function App ─────────────────────────────────────────────────────────────
resource functionApp 'Microsoft.Web/sites@2022-03-01' = {
  name: functionAppName
  location: location
  kind: 'functionapp,linux'
  identity: { type: 'SystemAssigned' }
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      linuxFxVersion: 'python|3.9'
      minTlsVersion: '1.2'
      ftpsState: 'Disabled'
      appSettings: [
        {
          name: 'AzureWebJobsStorage'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccount.name};EndpointSuffix=${environment().suffixes.storage};AccountKey=${storageAccount.listKeys().keys[0].value}'
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4'
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'python'
        }
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: appInsights.properties.InstrumentationKey
        }
        {
          name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          value: appInsights.properties.ConnectionString
        }
      ]
    }
  }
}

// ── Outputs ───────────────────────────────────────────────────────────────────
output functionAppName string = functionApp.name
output functionAppHostname string = functionApp.properties.defaultHostName
