$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest
$root = Resolve-Path "$PSScriptRoot\..\.."
$idx  = Join-Path $root "docs\roadmap\index.md"
if (-not (Test-Path $idx)) { Write-Error "index.md introuvable" }
$txt = Get-Content -Raw -LiteralPath $idx
$line = "- Etape 4 - Authentification: voir `docs/specs/auth_v1.md` (v1.0.0). Politique MDP 12+, verrou 5/15 min, messages FR."
if ($txt -notmatch "Etape 4 - Authentification") {
  $txt = $txt.TrimEnd() + [Environment]::NewLine + $line + [Environment]::NewLine
  Set-Content -LiteralPath $idx -Value $txt -Encoding UTF8
  Write-Host "Ajout de la ligne Auth v1 dans index.md"
} else {
  Write-Host "La ligne Auth v1 est deja presente dans index.md"
}
Exit 0
