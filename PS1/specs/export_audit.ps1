$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$root   = Resolve-Path "$PSScriptRoot\..\.."
$specDir= Join-Path $root "docs\specs"
New-Item -ItemType Directory -Force -Path $specDir | Out-Null

$mdPath = Join-Path $specDir "audit_log_v1.md"
$md = @'
# Spec - Audit Log v1

Version: 1.0.0
Objet: definir le schema JSON minimal des evenements de journalisation et les regles de validation (UTC, champs requis).

## Champs (obligatoires sauf mention)
- request_id: string (UUID v4 recommande)
- actor_id: string (UUID ou "system")
- resource: string (ex: "employee", "auth", "import")
- action: string (ex: "create", "update", "delete", "login_ok", "login_ko", "import_run")
- timestamp: string ISO 8601 en **UTC** (suffixe "Z"), ex: 2025-09-03T12:34:56.789Z
- details: objet JSON (key/value libres; pas de secrets)

## Niveaux et retention (minima)
- niveau: info|warning|error (defaut: info)
- retention: 90 jours (minima) en stockage primaire; export possible (v2)

## Exemples
OK (CRUD employee/create):
{
  "request_id": "b9a1c3af-3a7d-4a2f-8d5b-0b3b9c68f111",
  "actor_id": "3d1f2b0a-0d8f-44e5-9a1c-111122223333",
  "resource": "employee",
  "action": "create",
  "timestamp": "2025-09-03T10:00:00.000Z",
  "level": "info",
  "details": { "employee_email": "alice.courtois@example.com" }
}

KO (timestamp non UTC):
{
  "request_id": "b9a1c3af-3a7d-4a2f-8d5b-0b3b9c68f111",
  "actor_id": "system",
  "resource": "auth",
  "action": "login_ok",
  "timestamp": "2025-09-03T12:34:56+02:00",  // interdit: pas de "Z"
  "details": { "user": "bob@example.com" }
}

## Acceptation
- 1 OK: evenement conforme au schema.
- 1 KO: timestamp sans "Z" -> non conforme.

## Notes
- OpenTelemetry optionnel plus tard; mapping vers ce schema au niveau collector.
'@
Set-Content -LiteralPath $mdPath -Value $md -Encoding UTF8

Write-Host "export_audit: wrote $mdPath"
Exit 0
