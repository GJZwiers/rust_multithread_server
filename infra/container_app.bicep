@description('Sku of the workspace')
@allowed([
  'PerGB2018'
  'Free'
  'Standalone'
  'PerNode'
  'Standard'
  'Premium'
])
param sku string

@minValue(7)
@maxValue(730)
param retentionInDays int

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2021-06-01' = {
  name: 'containers-app-log-analytics-workspace'
  location: resourceGroup().location
  properties: {
    sku: {
      name: sku
    }
    retentionInDays: retentionInDays
  }
}

param name string

resource env 'Microsoft.Web/kubeEnvironments@2021-02-01' = {
  name: name
  location: resourceGroup().location
  properties: {
    type: 'managed'
    internalLoadBalancerEnabled: false
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: logAnalyticsWorkspace.properties.customerId
        sharedKey: logAnalyticsWorkspace.listKeys().primarySharedKey
      }
    }
  }
}

@minLength(3)
@maxLength(11)
param storagePrefix string

@allowed([
  'Standard_RAGRS'
  'Standard_RAGZRS'
])
param storageSKU string = 'Standard_RAGRS'

param location string = resourceGroup().location

var uniqueStorageName = '${storagePrefix}${uniqueString(resourceGroup().id)}'

resource stg 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: uniqueStorageName
  location: location
  sku: {
    name: storageSKU
  }
  kind: 'StorageV2'
  properties: {
    supportsHttpsTrafficOnly: true
  }
}
