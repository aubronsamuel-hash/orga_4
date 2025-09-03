$ErrorActionPreference = "Stop"; Set-StrictMode -Version Latest
docker compose -f ./deploy/compose.dev.yaml down -v
