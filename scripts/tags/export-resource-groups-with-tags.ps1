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

        $results += [PSCustomObject] @{
            SubscriptionName  = $subscription.Name
            ResourceGroup     = $resourceGroup.ResourceGroupName
            ResourceGroupTags = $resourceGroupTagString
        }
    }
}

$results | Export-Csv -Path ".\resource-group-tags.csv" -NoTypeInformation