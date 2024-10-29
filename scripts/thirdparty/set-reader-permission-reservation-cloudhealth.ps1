Install-Module Az.Reservations

TenantId = "TenantId"

Connect-AzAccount -Tenant $TenantId

$ROids = (Get-AzReservationOrder).id 
ForEach ($roid in $roids) { 

    New-AzRoleAssignment -Scope $roid -RoleDefinitionName "Reader" -ApplicationId "489fe005-26ab-40f8-a02d-5434232f6610" 

}