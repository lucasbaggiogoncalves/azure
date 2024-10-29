Connect-AzAccount

$results = @()

$subscriptions = Get-AzSubscription
foreach ($subscription in $subscriptions) {
    Set-AzContext -SubscriptionId $subscription.Id

    $resourceGroups = Get-AzResourceGroup
    foreach ($resourceGroup in $resourceGroups) {

        $resourceGroupTags = $resourceGroup.Tags
        if ($resourceGroupTags) {
            $resourceGroupTagString = ($resourceGroupTags.GetEnumerator() | ForEach-Object { "$($_.Key):$($_.Value)" }) -join ","
        }
        else {
            $resourceGroupTagString = $null
        }

        $resources = Get-AzResource -ResourceGroupName $resourceGroup.ResourceGroupName
        foreach ($resource in $resources) {
            $resourceTags = $resource.Tags
            if ($resourceTags) {
                $resourceTagString = ($resourceTags.GetEnumerator() | ForEach-Object { "$($_.Key):$($_.Value)" }) -join ","
            }
            else {
                $resourceTagString = $null
            }
            $results += [PSCustomObject] @{
                SubscriptionName  = $subscription.Name
                ResourceGroup     = $resourceGroup.ResourceGroupName
                ResourceGroupTags = $resourceGroupTagString
                Resource          = $resource.Name
                ResourceId        = $resource.Id
                ResourceTags      = $resourceTagString
            }
        }
    }
}

$results | Export-Csv -Path ".\resource-tag.csv" -NoTypeInformation