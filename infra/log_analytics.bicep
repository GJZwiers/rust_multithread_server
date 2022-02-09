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
param location string

resource env 'Microsoft.Web/kubeEnvironments@2021-02-01' = {
  name: name
  location: location
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
