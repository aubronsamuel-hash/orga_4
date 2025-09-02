$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$root = Resolve-Path "$PSScriptRoot\..\.."
$readme = Join-Path $root "README.md"
$index = Join-Path $root "docs\roadmap\index.md"
$specMdEmp = "docs/specs/employee_v1.md"
$specJsonEmp = "docs/specs/employee_v1.json"
$specMdOrg = "docs/specs/orgchart_v1.md"
$specJsonOrg = "docs/specs/orgchart_v1.json"
$specMdRBAC = "docs/specs/rbac_v1.md"
$specCsvRBAC= "docs/specs/rbac_v1.csv"
$specMdAuth = "docs/specs/auth_v1.md"
$specMdSettings = "docs/specs/org_settings_v1.md"

if (-not (Test-Path $readme)) { Write-Error "docs_guard: README.md missing" }
if (-not (Test-Path $index)) { Write-Error "docs_guard: docs/roadmap/index.md missing" }

$readmeText = Get-Content -Raw -LiteralPath $readme
$indexText  = Get-Content -Raw -LiteralPath $index

if ($readmeText -notmatch [regex]::Escape($specMdEmp)) {
  Write-Error "docs_guard: README must reference $specMdEmp"
}
if ($indexText -notmatch "Employe v1") {
  Write-Error "docs_guard: index.md must mention Employe v1"
}
if (-not (Test-Path (Join-Path $root $specMdEmp))) { Write-Error "docs_guard: $specMdEmp missing" }
if (-not (Test-Path (Join-Path $root $specJsonEmp))) { Write-Error "docs_guard: $specJsonEmp missing" }

# Nouveaux checks Organigramme v1
if ($readmeText -notmatch [regex]::Escape($specMdOrg)) {
  Write-Error "docs_guard: README must reference $specMdOrg"
}
if ($indexText -notmatch "Organigramme v1") {
  Write-Error "docs_guard: index.md must mention Organigramme v1"
}
if (-not (Test-Path (Join-Path $root $specMdOrg))) { Write-Error "docs_guard: $specMdOrg missing" }
if (-not (Test-Path (Join-Path $root $specJsonOrg))) { Write-Error "docs_guard: $specJsonOrg missing" }

# RBAC v1 checks
if ($readmeText -notmatch [regex]::Escape($specMdRBAC)) {
  Write-Error "docs_guard: README must reference $specMdRBAC"
}
if ($indexText -notmatch "RBAC v1") {
  Write-Error "docs_guard: index.md must mention RBAC v1"
}
if (-not (Test-Path (Join-Path $root $specMdRBAC))) { Write-Error "docs_guard: $specMdRBAC missing" }
if (-not (Test-Path (Join-Path $root $specCsvRBAC))) { Write-Error "docs_guard: $specCsvRBAC missing" }

# Auth v1 checks
if ($readmeText -notmatch [regex]::Escape($specMdAuth)) {
  Write-Error "docs_guard: README must reference $specMdAuth"
}
if ($indexText -notmatch "Auth v1") {
  Write-Error "docs_guard: index.md must mention Auth v1"
}
if (-not (Test-Path (Join-Path $root $specMdAuth))) { Write-Error "docs_guard: $specMdAuth missing" }

# Org Settings v1 checks
if ($readmeText -notmatch [regex]::Escape($specMdSettings)) {
  Write-Error "docs_guard: README must reference $specMdSettings"
}
if ($indexText -notmatch "Org Settings v1") {
  Write-Error "docs_guard: index.md must mention Org Settings v1"
}
if (-not (Test-Path (Join-Path $root $specMdSettings))) { Write-Error "docs_guard: $specMdSettings missing" }

$specMdNotif = "docs/specs/notifications_v1.md"

if ($readmeText -notmatch [regex]::Escape($specMdNotif)) {
Write-Error "docs_guard: README must reference $specMdNotif"
}
if ($indexText -notmatch "Notifications v1") {
Write-Error "docs_guard: index.md must mention Notifications v1"
}
if (-not (Test-Path (Join-Path $root $specMdNotif))) {
Write-Error "docs_guard: $specMdNotif missing"
}

$specMdI18n = "docs/specs/i18n_v1.md"

if ($readmeText -notmatch [regex]::Escape($specMdI18n)) {
  Write-Error "docs_guard: README must reference $specMdI18n"
}
if ($indexText -notmatch "i18n v1") {
  Write-Error "docs_guard: index.md must mention i18n v1"
}
if (-not (Test-Path (Join-Path $root $specMdI18n))) {
  Write-Error "docs_guard: $specMdI18n missing"
}

$specMdCF = "docs/specs/custom_fields_v1.md"
if ($readmeText -notmatch [regex]::Escape($specMdCF)) {
  Write-Error "docs_guard: README must reference $specMdCF"
}
if ($indexText -notmatch "Custom Fields v1") {
  Write-Error "docs_guard: index.md must mention Custom Fields v1"
}
if (-not (Test-Path (Join-Path $root $specMdCF))) {
  Write-Error "docs_guard: $specMdCF missing"
}

$specMdImport = "docs/specs/import_export_v1.md"

if ($readmeText -notmatch [regex]::Escape($specMdImport)) {
  Write-Error "docs_guard: README must reference $specMdImport"
}
if ($indexText -notmatch "Import/Export v1") {
  Write-Error "docs_guard: index.md must mention Import/Export v1"
}
if (-not (Test-Path (Join-Path $root $specMdImport))) {
  Write-Error "docs_guard: $specMdImport missing"
}

Write-Host "docs_guard: OK"
Exit 0
