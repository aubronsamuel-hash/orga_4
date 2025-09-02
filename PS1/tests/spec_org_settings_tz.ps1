$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

# Validator pragmatique pour TZ: accepte "UTC" ou quelques zones IANA courantes,
# et permet d'etendre la liste plus tard (backend/DB).
$AllowedIana = @(
  "UTC",
  "Europe/Paris",
  "Indian/Reunion",
  "America/New_York",
  "Europe/London"
)

function Test-TimeZoneValid {
  param([Parameter(Mandatory=$true)][string]$Tz)
  if ([string]::IsNullOrWhiteSpace($Tz)) { return $false }
  # Normaliser les espaces
  $tzTrim = $Tz.Trim()
  return ($AllowedIana -contains $tzTrim)
}

# 1 OK: TZ valide reconnu
$okTz = "Europe/Paris"
if (-not (Test-TimeZoneValid $okTz)) {
  Write-Host "[KO] expected valid TZ but rejected: $okTz" ; exit 1
} else {
  Write-Host "[OK] valid timezone accepted: $okTz"
}

# 1 KO: TZ inconnu -> erreur
$koTz = "Mars/Phobos"
if (Test-TimeZoneValid $koTz) {
  Write-Host "[KO] expected invalid TZ but accepted: $koTz" ; exit 1
} else {
  Write-Host "[OK] invalid timezone rejected: $koTz"
}

Write-Host "spec org settings TZ tests: PASS"
Exit 0
