module vnet 'vnet.bicep' = {
  name: 'vnet'
}

module storageAccount 'storage_account.bicep' = {
  name: 'storage_account'
  params: {
    storagePrefix: 'rustystore'
  }
}
