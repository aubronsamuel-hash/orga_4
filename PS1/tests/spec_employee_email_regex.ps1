$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$root = Resolve-Path "$PSScriptRoot\..\.."
$specJson = Join-Path $root "docs\specs\employee_v1.json"
if (-not (Test-Path $specJson)) {
  Write-Error "spec test: missing $specJson. Run PS1\specs\export_employe.ps1 first."
}

$spec = Get-Content -Raw -LiteralPath $specJson | ConvertFrom-Json -ErrorAction Stop
$regex = $spec.validation.email_regex
if ([string]::IsNullOrWhiteSpace($regex)) {
  Write-Error "spec test: email_regex missing in spec."
}

$valids = @(
  "samuel.aubron+test@exemple.fr",
  "x@x.fr",
  "user.name-123@sub.domain.co"
)
$invalids = @(
  "invalid-email",
  "foo@bar",
  "foo@bar.",
  " foo@bar.com "
)

$fail = $false
foreach ($v in $valids) {
  if ($v -notmatch $regex) {
    Write-Host "[KO] expected valid but failed: $v"
    $fail = $true
  } else {
    Write-Host "[OK] valid: $v"
  }
}
foreach ($v in $invalids) {
  if ($v -match $regex) {
    Write-Host "[KO] expected invalid but matched: $v"
    $fail = $true
  } else {
    Write-Host "[OK] invalid rejected: $v"
  }
}

if ($fail) { exit 1 } else { Write-Host "spec email regex tests: PASS"; exit 0 }
