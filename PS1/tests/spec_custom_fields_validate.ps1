$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

# Validateur de definition de champ custom (v1)
$AllowedTypes = @("string","int","date","enum")
$NamePattern  = '^[a-z][a-z0-9_]{1,30}$'

function Test-CFDefinition {
  param([hashtable]$Def, [hashtable]$RegistryPerScope)

  # Champs requis
  foreach ($k in @("name","label","type")) {
    if (-not $Def.ContainsKey($k)) { throw "Champ requis manquant: $k" }
  }
  if (-not ($Def.label -is [hashtable] -and $Def.label.fr -and $Def.label.en)) {
    throw "Labels FR/EN requis"
  }

  # Name format + unicite
  if ($Def.name -notmatch $NamePattern) { throw "Nom invalide: $($Def.name)" }
  $scope = $Def.scope
  if ([string]::IsNullOrWhiteSpace($scope)) { $scope = "employee" }
  if (-not $RegistryPerScope.ContainsKey($scope)) { $RegistryPerScope[$scope] = @{} }
  if ($RegistryPerScope[$scope].ContainsKey($Def.name)) { throw "Nom deja utilise dans le scope: $scope/$($Def.name)" }

  # Type autorise
  if ($AllowedTypes -notcontains $Def.type) { throw "Type invalide: $($Def.type)" }

  # Validations par type
  if ($Def.type -eq "string") {
    $min = $Def.validations.min_length
    $max = $Def.validations.max_length
    if ($min -and $min -lt 0) { throw "min_length < 0" }
    if ($max -and $min -and ($max -lt $min)) { throw "max_length < min_length" }
  }
  elseif ($Def.type -eq "int") {
    $min = $Def.validations.min
    $max = $Def.validations.max
    if ($max -and $min -and ($max -lt $min)) { throw "max < min (int)" }
    if ($Def.default -and ($Def.default -as [int]) -isnot [int]) { throw "default non entier" }
  }
  elseif ($Def.type -eq "date") {
    $min = $Def.validations.min_date
    $max = $Def.validations.max_date
    if ($min -and (-not ($min -match '^\d{4}-\d{2}-\d{2}$'))) { throw "min_date format invalide" }
    if ($max -and (-not ($max -match '^\d{4}-\d{2}-\d{2}$'))) { throw "max_date format invalide" }
    if ($min -and $max -and ([string]$max -lt [string]$min)) { throw "max_date < min_date" }
  }
  elseif ($Def.type -eq "enum") {
    if (-not $Def.enum_values -or $Def.enum_values.Count -lt 1) { throw "enum_values requis (>=1)" }
    $uniq = $Def.enum_values | Select-Object -Unique
    if ($uniq.Count -ne $Def.enum_values.Count) { throw "enum_values dupliques" }
  }

  # Si tout va bien, enregistrer
  $RegistryPerScope[$scope][$Def.name] = $true
  return $true
}

# Registry in-memory des noms utilises (par scope)
$reg = @{}

# 1) OK: creation d'un champ string valide
$cfOK = @{
  scope = "employee"
  name  = "badge_interne"
  label = @{ fr="Badge interne"; en="Internal badge" }
  type  = "string"
  required = $true
  validations = @{ min_length=4; max_length=12; regex='^[A-Z0-9-]{4,12}$' }
}
try {
  $res = Test-CFDefinition -Def $cfOK -RegistryPerScope $reg
  if (-not $res) { Write-Host "[KO] creation champ string valide a echoue" ; exit 1 }
  Write-Host "[OK] champ string valide cree"
} catch {
  Write-Host "[KO] exception inattendue (OK case): $($_.Exception.Message)" ; exit 1
}

# 2) KO: enum sans valeurs -> rejet
$cfKO = @{
  scope = "employee"
  name  = "habilitation_caces"
  label = @{ fr="Habilitation CACES"; en="CACES certification" }
  type  = "enum"
  enum_values = @()   # vide -> doit echouer
}
$failed = $false
try {
  $null = Test-CFDefinition -Def $cfKO -RegistryPerScope $reg
  Write-Host "[KO] enum sans valeurs aurait du etre refuse" ; $failed = $true
} catch {
  if ($_.Exception.Message -notmatch "enum_values requis") {
    Write-Host "[KO] message d'erreur inattendu: $($_.Exception.Message)" ; $failed = $true
  } else {
    Write-Host "[OK] enum sans valeurs rejete (attendu)"
  }
}
if ($failed) { exit 1 } else { Write-Host "spec custom fields tests: PASS"; exit 0 }

