$ErrorActionPreference = "Stop"; Set-StrictMode -Version Latest
Write-Host "[be_install] Create venv and install deps..." -ForegroundColor Cyan
if (-not (Test-Path "./backend/.venv")) { py -3 -m venv ./backend/.venv }
./backend/.venv/Scripts/python -m pip install --upgrade pip
./backend/.venv/Scripts/pip install -r ./backend/requirements.txt -r ./backend/requirements-dev.txt
