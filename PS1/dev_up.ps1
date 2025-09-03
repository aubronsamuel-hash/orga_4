$ErrorActionPreference = "Stop"; Set-StrictMode -Version Latest
if (-not (Test-Path ".env")) { Copy-Item ".env.example" ".env" -Force }
./PS1/be_install.ps1
$env:API_HOST = "127.0.0.1"; $env:API_PORT = "8000"
Start-Process -NoNewWindow -FilePath "powershell" -ArgumentList "-NoProfile","-ExecutionPolicy","Bypass","-File","./PS1/be_up.ps1"
