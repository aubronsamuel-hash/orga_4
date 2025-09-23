param([switch]$Strict)
$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot '..')
$repoRoot = Resolve-Path (Join-Path $repoRoot '..')
$lastOutputPath = Join-Path $repoRoot 'docs/codex/last_output.json'
if (-not (Test-Path $lastOutputPath)) {
  throw "commit_guard: missing file docs/codex/last_output.json"
}

try {
  $content = Get-Content -Raw -Path $lastOutputPath -Encoding UTF8
} catch {
  throw "commit_guard: unable to read docs/codex/last_output.json"
}

try {
  if ($content.Trim().Length -gt 0) {
    $null = $content | ConvertFrom-Json
  } elseif ($Strict) {
    throw "commit_guard: docs/codex/last_output.json empty"
  }
} catch {
  throw "commit_guard: invalid JSON in docs/codex/last_output.json"
}

Write-Host 'commit_guard OK'
