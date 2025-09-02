$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$root = Resolve-Path "$PSScriptRoot\..\.."
$specDir = Join-Path $root "docs\specs"
New-Item -ItemType Directory -Force -Path $specDir | Out-Null

# JSON
$jsonPath = Join-Path $specDir "employee_v1.json"
$json = @'
{ "version": "1.0.0", "entity": "employee",
  "fields": [
    {"name":"id","type":"uuid","required":true},
    {"name":"nom","type":"string","required":true,"min_length":2,"max_length":100},
    {"name":"prenom","type":"string","required":true,"min_length":1,"max_length":100},
    {"name":"email","type":"string","required":true,"unique":true,"pattern":"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"},
    {"name":"telephone","type":"string","required":false,"pattern":"^[0-9+(). -]{7,20}$"},
    {"name":"role_metier","type":"string","required":false,"enum":["regisseur","technicien","administratif","autre"]},
    {"name":"service","type":"string","required":false,"nullable":true},
    {"name":"site","type":"string","required":false,"nullable":true},
    {"name":"statut","type":"string","required":false,"enum":["actif","inactif","archive"],"default":"actif"},
    {"name":"date_entree","type":"date","required":false,"nullable":true},
    {"name":"date_sortie","type":"date","required":false,"nullable":true},
    {"name":"contrat_type","type":"string","required":false,"enum":["CDI","CDD","Intermittent","Freelance","Stage","Autre"]},
    {"name":"temps_travail","type":"number","required":false,"min":0,"max":100},
    {"name":"manager_id","type":"uuid","required":false,"nullable":true,"relation":"employee.id"}
  ],
  "constraints": [
    {"name":"email_unique","type":"unique","fields":["email"]},
    {"name":"manager_not_self","type":"check","expression":"manager_id IS NULL OR manager_id <> id"},
    {"name":"date_sortie_after_entree","type":"check","expression":"date_sortie IS NULL OR date_entree IS NULL OR date_sortie >= date_entree"}
  ],
  "pagination":{"default_limit":25,"max_limit":200},
  "identifiers":{"primary_key":["id"],"natural_key":["email"]},
  "validation":{"email_regex":"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$","telephone_regex":"^[0-9+(). -]{7,20}$"}
}
'@
Set-Content -LiteralPath $jsonPath -Value $json -Encoding UTF8

# Markdown
$mdPath = Join-Path $specDir "employee_v1.md"
$md = @'
# Spec fonctionnelle - Employe v1

Version: 1.0.0  
Objet: definir le modele Employe, les contraintes metier et le plan d'API CRUD.

## Modele de donnees (champ -> type -> contraintes)
- id: uuid, PK, requis.
- nom: string, 2..100, requis.
- prenom: string, 1..100, requis.
- email: string, requis, unique, format email (regex ci-dessous).
- telephone: string, optionnel, pattern: ^[0-9+(). -]{7,20}$ .
- role_metier: string, enum ex: regisseur|technicien|administratif|autre (ouvert).
- service: string, optionnel (code ou libelle).
- site: string, optionnel (code ou libelle).
- statut: string, enum: actif|inactif|archive (defaut: actif).
- date_entree: date, optionnel.
- date_sortie: date, optionnel, >= date_entree si presente.
- contrat_type: string, enum: CDI|CDD|Intermittent|Freelance|Stage|Autre.
- temps_travail: number (0..100), pourcentage d'equivalent temps plein.
- manager_id: uuid, optionnel, FK -> Employe.id, ne peut pas pointer vers soi-meme.

### Contraintes
- email unique (natural key).
- manager_not_self: manager_id IS NULL OR manager_id != id.
- date_sortie_after_entree: date_sortie IS NULL OR date_entree IS NULL OR date_sortie >= date_entree.

### Regex email (v1, pragmatique)
```
^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$
```
Note: regex volontairement simple; elle sera remplacee par une validation cote backend plus robuste (RFC partielle).

## Plan API preliminaire (CRUD) - prefix /api/v1
- GET /employees?limit=25&offset=0&search=... -> liste paginee (defaut limit 25, max 200).
- GET /employees/{id} -> detail.
- POST /employees -> creation (valide champs + unicite email).
- PATCH /employees/{id} -> MAJ partielle.
- DELETE /employees/{id} -> suppression logique (statut=archive) ou dure suivant politique.

Reponses: JSON, pagination par defaut (limit/offset, total), erreurs JSON structurees (code, message, details).

## Diagramme (ASCII)
```
+---------------------------+
|         EMPLOYEE         |
+---------------------------+
| id : uuid (PK)           |
| nom : string             |
| prenom : string          |
| email : string (UNIQUE)  |
| telephone : string       |
| role_metier : string     |
| service : string?        |
| site : string?           |
| statut : string          |
| date_entree : date?      |
| date_sortie : date?      |
| contrat_type : string    |
| temps_travail : number   |
| manager_id : uuid? (FK)  |
+---------------------------+
manager_id -> EMPLOYEE.id (0..1 manager, 0..N subordonnes)
```

## Exemples
- OK: samuel.aubron+test@exemple.fr
- KO: invalid-email

## Versionning
- v1.0.0: premiere version documentee. Les evolutions seront pistees dans employee_v1.json (champ version) et CHANGELOG.

---
'@
Set-Content -LiteralPath $mdPath -Value $md -Encoding UTF8

Write-Host "export_employe: wrote $jsonPath and $mdPath"
Exit 0
