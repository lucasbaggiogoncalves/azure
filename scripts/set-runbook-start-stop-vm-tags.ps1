############################################################################################
# Script validates VM tags:
#
# start-stop = true
# stop-time = HH:mm
# start-time = HH:mm
############################################################################################

Disable-AzContextAutosave -Scope Process

$AzureContext = (Connect-AzAccount -Identity).context
$AzureContext = Set-AzContext -SubscriptionName $AzureContext.Subscription -DefaultProfile $AzureContext


# Start VM

$startTime = "06:00"
$vmLocation = "brazilsouth"

$vmStart = Get-AzVM | Where-Object {
    $_.Tags.ContainsKey('start-stop') -and $_.Tags['start-stop'] -eq 'true' `
        -and $_.Tags.ContainsKey('start-time') -and $_.Tags['start-time'] -eq $startTime `
        -and $_.Location -eq $vmLocation
}

foreach ($vm in $vmStart) {
    Start-AzVM -ResourceGroupName $vm.ResourceGroupName -Name $vm.Name
}

# Stop VM

$stopTime = "18:00"

$vmStop = Get-AzVM | Where-Object {
    $_.Tags.ContainsKey('start-stop') -and $_.Tags['start-stop'] -eq 'true' `
        -and $_.Tags.ContainsKey('stop-time') -and $_.Tags['stop-time'] -eq $stopTime `
        -and $_.Location -eq $vmLocation
}

foreach ($vm in $vmStop) {
    Stop-AzVM -ResourceGroupName $vm.ResourceGroupName -Name $vm.Name
}