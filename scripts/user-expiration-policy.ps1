Install-Module -Name Microsoft.Graph -Scope CurrentUser

Connect-MgGraph -Scopes "OnPremDirectorySynchronization.ReadWrite.All"

(Get-MgUser -UserId "userid" -Property PasswordPolicies).PasswordPolicies