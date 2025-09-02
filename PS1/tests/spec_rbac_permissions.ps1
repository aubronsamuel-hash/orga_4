$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$root    = Resolve-Path "$PSScriptRoot\..\.."
$csvPath = Join-Path $root "docs\specs\rbac_v1.csv"
if (-not (Test-Path $csvPath)) {
  Write-Error "spec_rbac: missing $csvPath. Run PS1\specs\export_rbac.ps1 first."
}

# Load CSV into objects
$lines = Get-Content -LiteralPath $csvPath
if ($lines.Count -lt 2) { Write-Error "spec_rbac: CSV seems empty." }
$header = $lines[0].Split(",")
$records = @()
for ($i=1; $i -lt $lines.Count; $i++) {
  $cols = $lines[$i].Split(",")
  $obj = [ordered]@{}
  for ($c=0; $c -lt $header.Length; $c++) {
    $obj[$header[$c]] = $cols[$c]
  }
  $records += [pscustomobject]$obj
}

function Get-Decision {
  param([string]$resource,[string]$action,[string]$role)
  $row = $records | Where-Object { $_.resource -eq $resource -and $_.action -eq $action }
  if (-not $row) { return "deny" }
  switch ($role) {
    "admin"   { return $row.admin }
    "manager" { return $row.manager }
    "employe" { return $row.employe }
    default   { return "deny" }
  }
}

# Test OK: admin has all designated rights
$okPairs = @(
  @("employees","create"),
  @("employees","delete"),
  @("org_units","delete"),
  @("schedules","update")
)
foreach ($p in $okPairs) {
  $d = Get-Decision -resource $p[0] -action $p[1] -role "admin"
  if ($d -ne "allow") {
    Write-Host "[KO] expected admin allow on $($p[0])/$($p[1]) but got $d" ; exit 1
  }
}
Write-Host "[OK] admin has all designated rights"

# Test KO: employe cannot delete another employee
$decision = Get-Decision -resource "employees" -action "delete" -role "employe"
if ($decision -ne "deny") {
  Write-Host "[KO] expected employe deny on employees/delete, got $decision" ; exit 1
}
Write-Host "[OK] employe denied on employees/delete"

Write-Host "spec rbac tests: PASS"
Exit 0

