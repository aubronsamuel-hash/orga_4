$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$root = Resolve-Path "$PSScriptRoot\..\.."
$readme = Join-Path $root "README.md"
$index = Join-Path $root "docs\roadmap\index.md"
$specMd = "docs/specs/employee_v1.md"
$specJson = "docs/specs/employee_v1.json"

if (-not (Test-Path $readme)) { Write-Error "docs_guard: README.md missing" }
if (-not (Test-Path $index)) { Write-Error "docs_guard: docs/roadmap/index.md missing" }

$readmeText = Get-Content -Raw -LiteralPath $readme
$indexText  = Get-Content -Raw -LiteralPath $index

if ($readmeText -notmatch [regex]::Escape($specMd)) {
  Write-Error "docs_guard: README must reference $specMd"
}
if ($indexText -notmatch "Employe v1") {
  Write-Error "docs_guard: index.md must mention Employe v1"
}
if (-not (Test-Path (Join-Path $root $specMd))) { Write-Error "docs_guard: $specMd missing" }
if (-not (Test-Path (Join-Path $root $specJson))) { Write-Error "docs_guard: $specJson missing" }

Write-Host "docs_guard: OK"
Exit 0
