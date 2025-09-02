$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

Write-Host "[smoke] Roadmap quick check..."
& "$PSScriptRoot\tools\roadmap_guard.ps1" -Quick

Write-Host "[smoke] Export employee spec..."
& "$PSScriptRoot\specs\export_employe.ps1"
Write-Host "[smoke] Email regex quick test..."
& "$PSScriptRoot\tests\spec_employee_email_regex.ps1"

Write-Host "[smoke] Export orgchart spec..."
& "$PSScriptRoot\specs\export_org.ps1"
Write-Host "[smoke] Org hierarchy quick test..."
& "$PSScriptRoot\tests\spec_org_hierarchy.ps1"

Write-Host "[smoke] Export RBAC spec..."
& "$PSScriptRoot\specs\export_rbac.ps1"
Write-Host "[smoke] RBAC quick test..."
& "$PSScriptRoot\tests\spec_rbac_permissions.ps1"

Write-Host "[smoke] Export auth spec..."
& "$PSScriptRoot\specs\export_auth.ps1"
Write-Host "[smoke] Password policy quick test..."
& "$PSScriptRoot\tests\spec_auth_password_policy.ps1"

Write-Host "[smoke] Export org settings spec..."
& "$PSScriptRoot\specs\export_settings.ps1"
Write-Host "[smoke] Org settings TZ quick test..."
& "$PSScriptRoot\tests\spec_org_settings_tz.ps1"

Write-Host "[smoke] OK"
Exit 0
