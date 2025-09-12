import importlib
from fastapi.testclient import TestClient


def _get_app():
    try:
        from app.main import app as fastapi_app
        return fastapi_app
    except Exception:
        mod = importlib.import_module("app.main")
        if hasattr(mod, "create_app"):
            return mod.create_app()
        raise


def test_root_or_docs_available():
    app = _get_app()
    client = TestClient(app)
    ok = False
    for path in ("/", "/health", "/docs", "/openapi.json"):
        resp = client.get(path)
        if resp.status_code in (200, 307, 308):
            ok = True
            break
    assert ok, "No common endpoint responded with 2xx/3xx"
