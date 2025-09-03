$ErrorActionPreference = "Stop"; Set-StrictMode -Version Latest
pushd backend
../backend/.venv/Scripts/pip-audit -r requirements.txt
../backend/.venv/Scripts/pip-licenses --format=json --output-file ../sbom.json
popd
