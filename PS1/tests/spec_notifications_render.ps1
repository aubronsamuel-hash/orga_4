$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

function Get-TemplatePlaceholders {
param([Parameter(Mandatory=$true)][string]$Template)
# Match {{name}} with ASCII word chars, dots and underscores if needed
$matches = [regex]::Matches($Template, "{{([A-Za-z0-9_\.]+)}}")
$set = New-Object System.Collections.Generic.HashSet[string]
foreach ($m in $matches) { [void]$set.Add($m.Groups[1].Value) }
return ,$set
}

function Render-Template {
param(
  [Parameter(Mandatory=$true)][string]$Template,
  [Parameter(Mandatory=$true)][hashtable]$Data
)
$placeholders = Get-TemplatePlaceholders -Template $Template
# Validate presence
foreach ($k in $placeholders) {
  if (-not $Data.ContainsKey($k)) {
    throw "Placeholder manquant: $k"
  }
}
$out = $Template
foreach ($k in $placeholders) {
  $v = [string]$Data[$k]
  $vEsc = $v -replace '\\','\\\\' -replace '\$','$$'
  $out = $out -replace ("\{\{" + [regex]::Escape($k) + "\}\}"), $vEsc
}
return $out
}

# Template sample (employee.created)
$templateOK = @"
Bonjour {{employee_name}},
Votre compte a ete cree avec l'adresse {{employee_email}} le {{created_at}}.
"@

# 1 OK: rendu avec toutes les variables
$dataOK = @{
employee_name = "Alice Martin"
employee_email = "alice.martin@example.com"
created_at = "2025-09-03 10:00"
}
try {
$rendered = Render-Template -Template $templateOK -Data $dataOK
if ($rendered -notmatch "Alice Martin" -or $rendered -notmatch "alice.martin@example.com") {
  Write-Host "[KO] rendu ne contient pas les valeurs attendues" ; exit 1
}
Write-Host "[OK] rendu template avec placeholders completes"
} catch {
Write-Host "[KO] exception inattendue: $($_.Exception.Message)" ; exit 1
}

# 1 KO: placeholder manquant
$dataKO = @{
employee_name = "Bob"
# employee_email manquant
created_at = "2025-09-03 10:00"
}
$failed = $false
try {
$null = Render-Template -Template $templateOK -Data $dataKO
Write-Host "[KO] rendu aurait du echouer (placeholder manquant)" ; $failed = $true
} catch {
if ($_.Exception.Message -notmatch "Placeholder manquant: employee_email") {
  Write-Host "[KO] message d'erreur inattendu: $($_.Exception.Message)" ; $failed = $true
} else {
  Write-Host "[OK] erreur claire sur placeholder manquant"
}
}
if ($failed) { exit 1 } else { Write-Host "spec notifications render tests: PASS"; exit 0 }
