$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

# Regles minimales: champs requis + timestamp ISO 8601 en UTC (suffixe Z)
function Test-AuditEvent {
  param([hashtable]$E)

  foreach ($k in @("request_id","actor_id","resource","action","timestamp","details")) {
    if (-not $E.ContainsKey($k)) { throw "Champ requis manquant: $k" }
  }
  # timestamp doit se terminer par Z (UTC)
  $ts = [string]$E.timestamp
  if ($ts -notmatch '^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(\.\d{1,6})?Z$') {
    throw "Timestamp non UTC (doit finir par 'Z'): $ts"
  }
  return $true
}

# OK: evenement CRUD employee/create conforme
$ok = @{
  request_id = "b9a1c3af-3a7d-4a2f-8d5b-0b3b9c68f111"
  actor_id   = "3d1f2b0a-0d8f-44e5-9a1c-111122223333"
  resource   = "employee"
  action     = "create"
  timestamp  = "2025-09-03T10:00:00.000Z"
  level      = "info"
  details    = @{ employee_email = "alice.courtois@example.com" }
}
try {
  $res = Test-AuditEvent -E $ok
  if (-not $res) { Write-Host "[KO] evenement OK a echoue" ; exit 1 }
  Write-Host "[OK] evenement CRUD conforme au schema"
} catch {
  Write-Host "[KO] exception inattendue (OK case): $($_.Exception.Message)" ; exit 1
}

# KO: timestamp non UTC (offset +02:00)
$ko = @{
  request_id = "b9a1c3af-3a7d-4a2f-8d5b-0b3b9c68f111"
  actor_id   = "system"
  resource   = "auth"
  action     = "login_ok"
  timestamp  = "2025-09-03T12:34:56+02:00"  # interdit
  details    = @{ user = "bob@example.com" }
}
$failed = $false
try {
  $null = Test-AuditEvent -E $ko
  Write-Host "[KO] evenement KO aurait du etre refuse (timestamp non UTC)" ; $failed = $true
} catch {
  if ($_.Exception.Message -notmatch "Timestamp non UTC") {
    Write-Host "[KO] message d'erreur inattendu: $($_.Exception.Message)" ; $failed = $true
  } else {
    Write-Host "[OK] timestamp non UTC correctement refuse"
  }
}
if ($failed) { exit 1 } else { Write-Host "spec audit schema tests: PASS"; exit 0 }
