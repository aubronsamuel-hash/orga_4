$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$root = Resolve-Path "$PSScriptRoot\..\.."
$specDir = Join-Path $root "docs\specs"
New-Item -ItemType Directory -Force -Path $specDir | Out-Null

$mdPath = Join-Path $specDir "notifications_v1.md"
$md = @'
# Spec - Notifications v1

Version: 1.0.0
(Contenu: triggers employee.created, schedule.updated, auth.reset_requested; placeholders {{var}}; canaux email/in-app; regles de rendu/erreur.)
'@
Set-Content -LiteralPath $mdPath -Value $md -Encoding UTF8

Write-Host "export_notifications: wrote $mdPath"
Exit 0
