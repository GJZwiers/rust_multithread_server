targetScope = 'subscription'

resource vnetRG 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: 'vnet-rg'
  location: 'westeurope'
}

resource storageAccountsRG 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: 'storage-accounts-rg'
  location: 'westeurope'
}

resource appServiceRG 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: 'app-service-rg'
  location: 'westeurope'
}

resource containerAppRG 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: 'container-app-rg'
  location: 'westeurope'
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
