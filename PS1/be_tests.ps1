$ErrorActionPreference = "Stop"; Set-StrictMode -Version Latest
pushd backend
./.venv/Scripts/python -m pytest --maxfail=1 --disable-warnings --cov=app --cov-report=term-missing
popd
