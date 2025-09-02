param(
  [switch]$Quick
)
$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$root = Resolve-Path "$PSScriptRoot\..\.."
$roadmapDir = Join-Path $root "docs\roadmap"
if (-not (Test-Path $roadmapDir)) {
  Write-Error "roadmap_guard: dossier manquant: docs\roadmap"
}

$expectedFiles = @(
  "roadmap_01-10.md","roadmap_11-20.md","roadmap_21-30.md","roadmap_31-40.md",
  "roadmap_41-50.md","roadmap_51-60.md","roadmap_61-70.md","roadmap_71-80.md",
  "roadmap_81-90.md","roadmap_91-100.md","roadmap_101-110.md","roadmap_111-120.md",
  "roadmap_121-130.md","roadmap_131-140.md","roadmap_141-150.md","roadmap_151-160.md",
  "roadmap_161-170.md","roadmap_171-180.md","roadmap_181-190.md","roadmap_191-200.md"
)

foreach ($f in $expectedFiles) {
  $p = Join-Path $roadmapDir $f
  if (-not (Test-Path $p)) { Write-Error "roadmap_guard: fichier manquant: docs\roadmap\$f" }
  $c = Get-Content -Raw $p -ErrorAction Stop
  for ($i=1; $i -le 10; $i++) {
    $anchor = "## Etape $i"
    if ($c -notmatch [regex]::Escape($anchor)) {
      Write-Error "roadmap_guard: etape manquante '$anchor' dans $f"
    }
  }
}

$indexPath = Join-Path $roadmapDir "index.md"
if (-not (Test-Path $indexPath)) { Write-Error "roadmap_guard: index manquant: docs\roadmap\index.md" }
$index = Get-Content -Raw $indexPath
foreach ($f in $expectedFiles) {
  if ($index -notmatch [regex]::Escape($f)) {
    Write-Error "roadmap_guard: index ne reference pas $f"
  }
}

if (-not $Quick) {
  # Guard: enforce FR markers in roadmap files
  foreach ($f in $expectedFiles) {
    $p = Join-Path $roadmapDir $f
    $c = Get-Content -Raw $p
    foreach ($section in @("Objectif","Livrables","Scripts","Tests","CI Gates","Acceptation","Notes")) {
      if ($c -notmatch [regex]::Escape($section)) {
        Write-Error "roadmap_guard: section '$section' manquante dans $f"
      }
    }
  }
}

Write-Host "roadmap_guard: OK"
Exit 0
