$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

function Read-CsvSemicolon {
  param([string]$Path)
  $lines = Get-Content -LiteralPath $Path
  if ($lines.Count -lt 2) { throw "CSV vide ou entete seule: $Path" }
  $header = $lines[0].Split(";")
  $rows = @()
  for ($i=1; $i -lt $lines.Count; $i++) {
    $cols = $lines[$i].Split(";")
    $obj = [ordered]@{}
    for ($c=0; $c -lt $header.Length; $c++) { $obj[$header[$c]] = $cols[$c] }
    $rows += [pscustomobject]$obj
  }
  return ,$rows
}

# Simple email regex (align employee_v1)
$EmailRegex = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'

function Validate-EmployeesCsv {
  param([string]$Path)
  $rows = Read-CsvSemicolon -Path $Path
  $errors = @()
  $seenEmails = @{}

  for ($i=0; $i -lt $rows.Count; $i++) {
    $r = $rows[$i]
    $lineNo = $i + 2 # header is line 1
    $email = ($r.email).Trim()
    $nom   = ($r.nom).Trim()
    $prenom= ($r.prenom).Trim()

    if ([string]::IsNullOrWhiteSpace($nom))    { $errors += "L$lineNo;nom;REQUIRED" }
    if ([string]::IsNullOrWhiteSpace($prenom)) { $errors += "L$lineNo;prenom;REQUIRED" }
    if ([string]::IsNullOrWhiteSpace($email))  { $errors += "L$lineNo;email;REQUIRED" }
    elseif ($email -notmatch $EmailRegex)      { $errors += "L$lineNo;email;INVALID_FORMAT" }
    elseif ($seenEmails.ContainsKey($email))   { $errors += "L$lineNo;email;EMAIL_DUPLICATE" }
    else { $seenEmails[$email] = $true }
  }

  return ,$errors
}

$root = Resolve-Path "$PSScriptRoot\..\.."
$okCsv  = Join-Path $root "docs\samples\employees_sample_ok.csv"
$dupCsv = Join-Path $root "docs\samples\employees_sample_dup.csv"

if (-not (Test-Path $okCsv -PathType Leaf)) { Write-Error "Sample manquant: $okCsv (run export_import.ps1)" }
if (-not (Test-Path $dupCsv -PathType Leaf)) { Write-Error "Sample manquant: $dupCsv (run export_import.ps1)" }

# 1) OK: import d'une ligne valide
$errsOK = Validate-EmployeesCsv -Path $okCsv
if ($errsOK.Count -ne 0) {
  Write-Host "[KO] sample OK devrait avoir 0 erreur, trouve: $($errsOK -join ', ')" ; exit 1
} else {
  Write-Host "[OK] sample OK valide (0 erreur)"
}

# 2) KO: doublon email -> echec avec rapport
$errsDup = Validate-EmployeesCsv -Path $dupCsv
if (-not ($errsDup | Where-Object { $_ -match "EMAIL_DUPLICATE" })) {
  Write-Host "[KO] attendu EMAIL_DUPLICATE dans sample KO, erreurs: $($errsDup -join ', ')" ; exit 1
} else {
  Write-Host "[OK] doublon email detecte (EMAIL_DUPLICATE)"
  Write-Host "Rapport: $($errsDup -join '; ')"
}

Write-Host "spec import/export CSV tests: PASS"
Exit 0
