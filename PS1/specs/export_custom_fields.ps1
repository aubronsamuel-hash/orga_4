$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$root   = Resolve-Path "$PSScriptRoot\..\.."
$specDir= Join-Path $root "docs\specs"
New-Item -ItemType Directory -Force -Path $specDir | Out-Null

$mdPath = Join-Path $specDir "custom_fields_v1.md"
$md = @'
# Spec - Custom Fields v1

Version: 1.0.0
(Contenu: scope employee; types string/int/date/enum; name unique par scope; validations par type; exemples FR.)
'@
Set-Content -LiteralPath $mdPath -Value $md -Encoding UTF8

Write-Host "export_custom_fields: wrote $mdPath"
Exit 0
