Install-Module -Name Microsoft.Graph -Scope CurrentUser

Connect-MgGraph -TenantId "tenantid" -Scopes "Directory.AccessAsUser.All"
(Get-MgUser -UserId "user-object-id" -Property PasswordPolicies).PasswordPolicies


Connect-MgGraph -TenantId "tenantid" -Scopes "OnPremDirectorySynchronization.ReadWrite.All"
$OnPremSync = Get-MgDirectoryOnPremiseSynchronization
$OnPremSync.Features.CloudPasswordPolicyForPasswordSyncedUsersEnabled = $true
Update-MgDirectoryOnPremiseSynchronization -OnPremisesDirectorySynchronizationId $OnPremSync.Id -Features $OnPremSync.Features

Start-ADSyncSyncCycle -PolicyType Delta

Update-MgUser -UserId "user-object-id" -PasswordPolicies DisablePasswordExpiration

# Política de senha

Install-Module -Name Microsoft.Graph -AllowClobber -Force
Connect-MgGraph -TenantId "tenantid" -Scopes "Directory.Read.All"
Get-MgOrganization | Select-Object -Property PasswordPolicies, PasswordProfile