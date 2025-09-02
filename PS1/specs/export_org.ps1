$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$root = Resolve-Path "$PSScriptRoot\..\.."
$specDir = Join-Path $root "docs\specs"
New-Item -ItemType Directory -Force -Path $specDir | Out-Null

# JSON
$jsonPath = Join-Path $specDir "orgchart_v1.json"
$json = @'
{
  "version": "1.0.0",
  "entity": "orgchart",
  "service": {
    "fields": [
      {"name":"code","type":"string","required":true,"unique":true,"min_length":2,"max_length":30,"pattern":"^[A-Z0-9_-]+$"},
      {"name":"libelle","type":"string","required":true,"min_length":2,"max_length":100}
    ],
    "identifiers":{"primary_key":["code"]}
  },
  "team": {
    "fields": [
      {"name":"code","type":"string","required":true,"unique":true,"min_length":2,"max_length":30,"pattern":"^[A-Z0-9_-]+$"},
      {"name":"libelle","type":"string","required":true,"min_length":2,"max_length":100},
      {"name":"service_code","type":"string","required":true,"relation":"service.code"}
    ],
    "identifiers":{"primary_key":["code"]}
  },
  "hierarchy": {
    "constraints": [
      {"name":"no_self_manager","type":"check","expression":"manager_id IS NULL OR manager_id <> id"},
      {"name":"acyclic_management","type":"graph_rule","description":"No cycles A->...->A in management graph"},
      {"name":"unbounded_children","type":"rule","description":"A manager may have 0..N direct reports"}
    ]
  },
  "relations": [
    {"from":"team.service_code","to":"service.code"},
    {"from":"employee.manager_id","to":"employee.id"}
  ]
}
'@
Set-Content -LiteralPath $jsonPath -Value $json -Encoding UTF8

# Markdown
$mdPath = Join-Path $specDir "orgchart_v1.md"
$md = @'
# Spec fonctionnelle - Organigramme v1

Version: 1.0.0
Objet: services, equipes, liens manager->subordonnes; pas de cycles; N subordonnes autorises.

(Contenu synchronise avec orgchart_v1.json. Voir entites Service/Equipe, contraintes, plan API lecture, wireframe texte.)
'@
Set-Content -LiteralPath $mdPath -Value $md -Encoding UTF8

Write-Host "export_org: wrote $jsonPath and $mdPath"
Exit 0
