$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

Write-Host "[test_all] Running roadmap guard..."
& "$PSScriptRoot\tools\roadmap_guard.ps1"

Write-Host "[test_all] Exporting employee spec..."
& "$PSScriptRoot\specs\export_employe.ps1"
Write-Host "[test_all] Running spec email regex tests..."
& "$PSScriptRoot\tests\spec_employee_email_regex.ps1"

Write-Host "[test_all] Exporting orgchart spec..."
& "$PSScriptRoot\specs\export_org.ps1"
Write-Host "[test_all] Running org hierarchy tests..."
& "$PSScriptRoot\tests\spec_org_hierarchy.ps1"

Write-Host "[test_all] Exporting RBAC spec..."
& "$PSScriptRoot\specs\export_rbac.ps1"
Write-Host "[test_all] Running RBAC tests..."
& "$PSScriptRoot\tests\spec_rbac_permissions.ps1"

Write-Host "[test_all] Exporting auth spec..."
& "$PSScriptRoot\specs\export_auth.ps1"
Write-Host "[test_all] Running password policy tests..."
& "$PSScriptRoot\tests\spec_auth_password_policy.ps1"

Write-Host "[test_all] Exporting org settings spec..."
& "$PSScriptRoot\specs\export_settings.ps1"
Write-Host "[test_all] Running org settings TZ tests..."
& "$PSScriptRoot\tests\spec_org_settings_tz.ps1"

Write-Host "[test_all] Exporting notifications spec..."
& "$PSScriptRoot\specs\export_notifications.ps1"
Write-Host "[test_all] Running notifications render tests..."
& "$PSScriptRoot\tests\spec_notifications_render.ps1"

Write-Host "[test_all] Exporting i18n spec..."
& "$PSScriptRoot\specs\export_i18n.ps1"
Write-Host "[test_all] Running i18n policy tests..."
& "$PSScriptRoot\tests\spec_i18n_policy.ps1"

Write-Host "[test_all] DONE"
Exit 0
