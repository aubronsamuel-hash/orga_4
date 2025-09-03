$ErrorActionPreference = "Stop"; Set-StrictMode -Version Latest
Write-Host "[be_seed] Seeding demo data..." -ForegroundColor Cyan
./backend/.venv/Scripts/python - <<'PY'
from app.db.session import SessionLocal
from app.db.models.org import Org
from app.db.models.user import User

db = SessionLocal()
o = Org(name="Demo Org")
db.add(o)
db.flush()
db.add_all([
    User(email="rg@demo.test", org_id=o.id, display_name="Regisseur General"),
    User(email="tech@demo.test", org_id=o.id, display_name="Technicien"),
])
db.commit()
db.close()
print("OK")
PY
