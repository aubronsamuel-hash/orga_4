$ErrorActionPreference = "Stop"; Set-StrictMode -Version Latest
Write-Host "[smoke] Pinging health..." -ForegroundColor Cyan
$resp = Invoke-RestMethod -Uri "http://$env:API_HOST`:$env:API_PORT/api/v1/health"
if ($resp.status -ne "ok") { throw "Health NOK" }
Write-Host "[smoke] OK" -ForegroundColor Green
