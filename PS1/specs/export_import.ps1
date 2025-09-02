$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$root    = Resolve-Path "$PSScriptRoot\..\.."
$specDir = Join-Path $root "docs\specs"
$sampleDir = Join-Path $root "docs\samples"
New-Item -ItemType Directory -Force -Path $specDir   | Out-Null
New-Item -ItemType Directory -Force -Path $sampleDir | Out-Null

# Write spec MD
$mdPath = Join-Path $specDir "import_export_v1.md"
$md = @'
# Spec - Import/Export v1

Version: 1.0.0
Objet: definir le format CSV/Excel d'echange des employes et les regles de mapping/validation.

## Format CSV (UTF-8, ; separateur)
Colonnes et types:
- id (UUID, optionnel a l'import; genere si vide)
- nom (string 2..100, requis)
- prenom (string 1..100, requis)
- email (string, requis, unique, format email v1)
- telephone (string, optionnel)
- role_metier (string, optionnel)
- service (string, optionnel)
- site (string, optionnel)
- statut (string enum: actif|inactif|archive; defaut actif)
- date_entree (date ISO yyyy-MM-dd, optionnel)
- date_sortie (date ISO yyyy-MM-dd, optionnel)
- contrat_type (enum: CDI|CDD|Intermittent|Freelance|Stage|Autre, optionnel)
- temps_travail (number 0..100, optionnel)
- manager_email (string, optionnel; mapping vers manager_id)

## Regles de validation
- email: format conforme a employee_v1 + unicite dans le fichier ET en base (intra-fichier v1).
- date_sortie >= date_entree si presentes.
- statut conforme a l'enum.
- Si manager_email renseigne, il doit exister (ou etre resolu dans un second passage v2).

## Mapping (v1)
- manager_email -> manager_id (resolution exterieure au scope de ce lot).
- colonnes non reconnues -> ignorees (warning).

## Erreurs
- Rapport CSV/texte listant: ligne, colonne, erreur (FR), code (ex: EMAIL_DUPLICATE).

## Exemples (voir /docs/samples)
- employees_sample_ok.csv : 1 ligne valide.
- employees_sample_dup.csv : 2 lignes dont doublon email -> KO.

## Acceptation
- 1 OK: import d'une ligne valide.
- 1 KO: doublon email -> echec avec message.

---
'@
Set-Content -LiteralPath $mdPath -Value $md -Encoding UTF8

# Samples
$okCsvPath = Join-Path $sampleDir "employees_sample_ok.csv"
$dupCsvPath = Join-Path $sampleDir "employees_sample_dup.csv"

$ok = @'
id;nom;prenom;email;telephone;role_metier;service;site;statut;date_entree;date_sortie;contrat_type;temps_travail;manager_email
;courtois;alice;alice.courtois@example.com;;administratif;RH;PARIS;actif;2025-01-10;;CDI;100;
'@
Set-Content -LiteralPath $okCsvPath -Value $ok -Encoding UTF8

$dup = @'
id;nom;prenom;email;telephone;role_metier;service;site;statut;date_entree;date_sortie;contrat_type;temps_travail;manager_email
;dupont;bob;dup@example.com;;technicien;OPS;PARIS;actif;2024-03-01;;CDD;80;
;durand;carla;dup@example.com;;technicien;OPS;PARIS;actif;2024-04-01;;CDD;80;
'@
Set-Content -LiteralPath $dupCsvPath -Value $dup -Encoding UTF8

Write-Host "export_import: wrote $mdPath, $okCsvPath and $dupCsvPath"
Exit 0
