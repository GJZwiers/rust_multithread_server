module vnet 'vnet.bicep' = {
  name: 'vnet'
}

module storageAccount 'storage_account.bicep' = {
  name: 'storage_account'
  params: {
    storagePrefix: 'rustystore'
  }
}

module appService 'app-service.bicep' = {
  name: 'app_service'
}
