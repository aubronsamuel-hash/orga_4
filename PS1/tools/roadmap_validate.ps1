$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

Write-Host "[roadmap_validate] Debut validation roadmap/docs..." -ForegroundColor Cyan

$toolRoot = $PSScriptRoot

# 1) Markdown lint (optional si present)
$mdlint = Join-Path $toolRoot "mdlint.ps1"
if (Test-Path $mdlint) {
  & $mdlint
}

# 2) Roadmap guard
$roadmapGuard = Join-Path $toolRoot "roadmap_guard.ps1"
if (Test-Path $roadmapGuard) {
  & $roadmapGuard -Verbose
} else {
  Write-Host "[roadmap_validate] tools\\roadmap_guard.ps1 non present -> skip (OK si CI l'executera)" -ForegroundColor Yellow
}

# 3) Docs guard
$docsGuard = Join-Path $toolRoot "docs_guard.ps1"
if (Test-Path $docsGuard) {
  & $docsGuard -Verbose
} else {
  Write-Host "[roadmap_validate] tools\\docs_guard.ps1 non present -> skip (OK si CI l'executera)" -ForegroundColor Yellow
}

Write-Host "[roadmap_validate] Validation terminee." -ForegroundColor Green
