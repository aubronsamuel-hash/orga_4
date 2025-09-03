$ErrorActionPreference = "Stop"; Set-StrictMode -Version Latest
Write-Host "[be_up] Starting Postgres+Redis (compose.dev)..." -ForegroundColor Cyan
docker compose -f ./deploy/compose.dev.yaml up -d db redis
Write-Host "[be_up] Running API (uvicorn)..." -ForegroundColor Cyan
./backend/.venv/Scripts/python -m uvicorn app.main:app --host $env:API_HOST --port $env:API_PORT --reload
