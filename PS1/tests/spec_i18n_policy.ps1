$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

# Mini-kv pour test (simule locales)
$fr = @{
  "auth.login.title" = "Connexion"
  "auth.password.label" = "Mot de passe"
  "menu.employees" = "Employes"
  "employees.form.email.label" = "Email professionnel"
  "employees.form.save" = "Enregistrer"
}
$en = @{
  "auth.login.title" = "Sign in"
  # "auth.password.label" manquante -> doit fallback FR
  "menu.employees" = "Employees"
  "employees.form.email.label" = "Work email"
  "employees.form.save" = "Save"
}

function Get-I18n {
  param(
    [Parameter(Mandatory=$true)][string]$Key,
    [Parameter(Mandatory=$true)][hashtable]$Primary,
    [Parameter(Mandatory=$true)][hashtable]$Fallback
  )
  if ($Primary.ContainsKey($Key)) { return $Primary[$Key] }
  if ($Fallback.ContainsKey($Key)) { return $Fallback[$Key] }
  return $Key  # cle brute si absente partout
}

# 1) OK: fallback vers FR si manquant en EN
$val = Get-I18n -Key "auth.password.label" -Primary $en -Fallback $fr
if ($val -ne "Mot de passe") {
  Write-Host "[KO] expected fallback FR, got: $val" ; exit 1
} else {
  Write-Host "[OK] fallback -> FR fonctionne"
}

# 2) KO: cle dupliquee signalee (on simule un chargement avec doublon)
$keys = @("menu.employees","menu.employees","auth.login.title")
$dups = @($keys | Group-Object | Where-Object { $_.Count -gt 1 } | Select-Object -ExpandProperty Name)
if ($dups.Count -gt 0) {
  Write-Host "[OK] duplication detectee: $($dups -join ', ')"
} else {
  Write-Host "[KO] duplication non detectee" ; exit 1
}

Write-Host "spec i18n policy tests: PASS"
Exit 0
