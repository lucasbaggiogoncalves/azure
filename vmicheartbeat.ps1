Set-Service "vmicheartbeat" -StartupType Manual
Start-Service "vmicheartbeat"
Get-Service "vmicheartbeat" | Select-Object -property name,starttype,status