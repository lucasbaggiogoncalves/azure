$tenantId = ""

Connect-AzAccount -TenantId $tenantId

$subscriptions = Get-AzSubscription -TenantId $tenantId

$allResources = @()

foreach ($subscription in $subscriptions) {
    
    Set-AzContext -SubscriptionId $subscription.Id

    $resources = Get-AzResource | Select-Object Name, @{Name="ResourceType"; Expression={$_.ResourceType.Split("/")[-1]}}, ResourceGroupName, @{Name="Region"; Expression={$_.Location}}, @{Name="Subscription"; Expression={$subscription.Name}}

    $allResources += $resources
}

$allResources | Export-Csv -Path "./all_resources.csv" -NoTypeInformation -Encoding UTF8