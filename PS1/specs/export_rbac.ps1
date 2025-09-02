$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$root   = Resolve-Path "$PSScriptRoot\..\.."
$specDir= Join-Path $root "docs\specs"
New-Item -ItemType Directory -Force -Path $specDir | Out-Null

# Define matrix in memory
$rows = @(
  @{resource="employees"; action="read:list"   ; admin="allow"; manager="allow"; employe="allow"},
  @{resource="employees"; action="read:detail" ; admin="allow"; manager="allow"; employe="allow"},
  @{resource="employees"; action="create"     ; admin="allow"; manager="allow"; employe="deny" },
  @{resource="employees"; action="update"     ; admin="allow"; manager="allow"; employe="deny" },
  @{resource="employees"; action="delete"     ; admin="allow"; manager="deny" ; employe="deny" },
  @{resource="org_units"; action="read:list"  ; admin="allow"; manager="allow"; employe="allow"},
  @{resource="org_units"; action="read:detail"; admin="allow"; manager="allow"; employe="allow"},
  @{resource="org_units"; action="create"     ; admin="allow"; manager="deny" ; employe="deny" },
  @{resource="org_units"; action="update"     ; admin="allow"; manager="deny" ; employe="deny" },
  @{resource="org_units"; action="delete"     ; admin="allow"; manager="deny" ; employe="deny" },
  @{resource="schedules"; action="read:list"  ; admin="allow"; manager="allow"; employe="allow"},
  @{resource="schedules"; action="read:detail"; admin="allow"; manager="allow"; employe="allow"},
  @{resource="schedules"; action="create"     ; admin="allow"; manager="allow"; employe="deny" },
  @{resource="schedules"; action="update"     ; admin="allow"; manager="allow"; employe="deny" },
  @{resource="schedules"; action="delete"     ; admin="allow"; manager="deny" ; employe="deny" }
)

# Write CSV
$csvPath = Join-Path $specDir "rbac_v1.csv"
"resource,action,admin,manager,employe" | Set-Content -LiteralPath $csvPath -Encoding UTF8
foreach ($r in $rows) {
  "$($r.resource),$($r.action),$($r.admin),$($r.manager),$($r.employe)" | Add-Content -LiteralPath $csvPath -Encoding UTF8
}

# Write Markdown table
$mdPath = Join-Path $specDir "rbac_v1.md"
$md = @()
$md += "# Matrice RBAC v1"
$md += ""
$md += "Version: 1.0.0"
$md += "Objet: definir les droits initiaux par role (admin, manager, employe) sur les ressources critiques court terme."
$md += ""
$md += "## Ressources cibles (v1)"
$md += "- employees"
$md += "- org_units (services/equipes)"
$md += "- schedules"
$md += ""
$md += "## Actions standard"
$md += "- read:list, read:detail, create, update, delete"
$md += ""
$md += "## Regles v1"
$md += "- admin: tous les droits sur toutes les ressources."
$md += "- manager: lecture sur tout, creation/update limitees au perimetre d'equipe (politique precisee plus tard), pas de delete sur org_units; delete employees restreint (v2)."
$md += "- employe: lecture de base (self + donnees publiques), pas de create/update/delete sauf operations personnelles futures (v2)."
$md += ""
$md += "Voir tableau CSV/Markdown pour la matrice de verite."
$md += ""
$md += "### Tableau (extrait aligne au CSV)"
$md += "resource | action      | admin | manager | employe"
foreach ($r in $rows) {
  $md += ([string]::Format("{0}| {1,-11} | {2,-5} | {3,-7} | {4,-7}",$r.resource,$r.action,$r.admin,$r.manager,$r.employe))
}
$md += ""
$md += "Notes:"
$md += '- Les contraintes "perimetre d''equipe" seront definies applicativement a l''etape backend correspondante.'
$md += '- Une granularite par champ (field-level) sera traitee en extension (v2).'
$mdText = ($md -join [Environment]::NewLine)
Set-Content -LiteralPath $mdPath -Value $mdText -Encoding UTF8

Write-Host "export_rbac: wrote $csvPath and $mdPath"
Exit 0

