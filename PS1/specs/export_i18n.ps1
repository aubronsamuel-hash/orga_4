$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$root   = Resolve-Path "$PSScriptRoot\..\.."
$specDir= Join-Path $root "docs\specs"
New-Item -ItemType Directory -Force -Path $specDir | Out-Null

$mdPath = Join-Path $specDir "i18n_v1.md"
$md = @'
# Spec - i18n v1

Version: 1.0.0
(Contenu: FR/EN; cles "domaine.sousdomaine.element"; JSON par locale; fallback -> fr; duplication interdite; liste initiale de cles.)
'@
Set-Content -LiteralPath $mdPath -Value $md -Encoding UTF8

Write-Host "export_i18n: wrote $mdPath"
Exit 0
