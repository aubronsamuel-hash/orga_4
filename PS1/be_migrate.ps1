$ErrorActionPreference = "Stop"; Set-StrictMode -Version Latest
pushd backend
./.venv/Scripts/alembic.exe upgrade head
popd
