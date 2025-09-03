# Backend Coulisses Crew (FastAPI)

Prérequis Windows: Python 3.11+, Docker Desktop, PowerShell 7.
Ports: API 8000, Postgres 5432, Redis 6379.

## Commandes
1. Copier `.env.example` -> `.env` (adapter si besoin).
2. PowerShell:
   - `./PS1/be_install.ps1`
   - `./PS1/be_up.ps1`   (compose db/redis + API Uvicorn)
   - `./PS1/be_migrate.ps1`
   - `./PS1/be_seed.ps1`
   - `./PS1/smoke.ps1`   (GET /api/v1/health)
   - `./PS1/be_tests.ps1`
   - `./PS1/be_audit.ps1`

Sécurité: en-têtes HTTP, CORS limité par `CORS_ORIGINS`, rate limiting (429), logs JSON avec `request_id`.
Base de données: Alembic. Données en UTC. Pas de secrets dans le repo.
