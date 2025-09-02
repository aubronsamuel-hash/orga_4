$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$root = Resolve-Path "$PSScriptRoot\..\.."
$specDir = Join-Path $root "docs\specs"
New-Item -ItemType Directory -Force -Path $specDir | Out-Null

$mdPath = Join-Path $specDir "org_settings_v1.md"
$md = @'
# Spec - Org Settings v1

Version: 1.0.0
(Contenu: structure multi-sites, timezone_default/devise_default/locale_default, formats date/heure/nombres, politiques RH. Validation TZ (IANA/UTC).)
'@
Set-Content -LiteralPath $mdPath -Value $md -Encoding UTF8

Write-Host "export_settings: wrote $mdPath"
Exit 0
