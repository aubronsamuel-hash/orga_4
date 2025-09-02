$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

# Politique MDP (miroir de docs/specs/auth_v1.md)
$MinLen = 12
$reUpper = '[A-Z]'
$reLower = '[a-z]'
$reDigit = '[0-9]'
$reSpec  = '[!@#$%^&*()_+\-=\[\]{};:\'"",.<>\/\?`~\\]'
$blacklist = @("password","123456","qwerty","azerty")

function Test-Password {
  param([Parameter(Mandatory=$true)][string]$Pwd)
  if ([string]::IsNullOrWhiteSpace($Pwd)) { return $false }
  if ($Pwd.StartsWith(" ") -or $Pwd.EndsWith(" ")) { return $false }
  if ($Pwd.Length -lt $MinLen) { return $false }
  if ($Pwd -notmatch $reUpper) { return $false }
  if ($Pwd -notmatch $reLower) { return $false }
  if ($Pwd -notmatch $reDigit) { return $false }
  if ($Pwd -notmatch $reSpec)  { return $false }
  $lower = $Pwd.ToLowerInvariant()
  foreach ($b in $blacklist) {
    if ($lower -like "*$b*") { return $false }
  }
  return $true
}

# 1 OK: mot de passe conforme
$ok = "Securite2025!Alpha"
if (-not (Test-Password $ok)) {
  Write-Host "[KO] expected OK for password: $ok" ; exit 1
} else {
  Write-Host "[OK] valid password accepted"
}

# 1 KO: trop court
$ko = "short1!"
if (Test-Password $ko) {
  Write-Host "[KO] expected KO for too short password: $ko" ; exit 1
} else {
  Write-Host "[OK] short password rejected (as expected)"
}

Write-Host "spec auth password policy tests: PASS"
Exit 0
