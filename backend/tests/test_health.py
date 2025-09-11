import importlib

try:
    from app.main import app as fastapi_app
except Exception:
    mod = importlib.import_module('app.main')
    if hasattr(mod, 'create_app'):
        fastapi_app = mod.create_app()
    else:
        raise

from fastapi.testclient import TestClient


def test_health_endpoint_ok():
    client = TestClient(fastapi_app)
    resp = client.get('/health')
    assert resp.status_code == 200
