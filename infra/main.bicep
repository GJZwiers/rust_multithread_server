targetScope = 'subscription'
param location string = 'westeurope'

resource vnetRG 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: 'vnet-rg'
  location: location
}

resource storageAccountsRG 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: 'storage-accounts-rg'
  location: location
}

resource appServiceRG 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: 'app-service-rg'
  location: location
}

resource containerAppRG 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: 'container-app-rg'
  location: location
}

module vnet 'vnet.bicep' = {
  name: 'vnet'
  scope: vnetRG
}

module storageAccount 'storage_account.bicep' = {
  name: 'storage_account'
  scope: storageAccountsRG
  params: {
    storagePrefix: 'rustystore'
  }
}

module appService 'app-service.bicep' = {
  name: 'app_service'
  scope: appServiceRG
}

module containerAppService 'container_app.bicep' = {
  name: 'log_analytics'
  scope: containerAppRG
  params: {
    name: 'containerapp'
    sku: 'PerGB2018'
    retentionInDays: 30
    storagePrefix: 'containerstore'
  }
}
