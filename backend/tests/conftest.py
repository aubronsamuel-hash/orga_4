import pytest
from fastapi.testclient import TestClient
from app.main import app


@pytest.fixture(scope="session", autouse=True)
def ensure_db_ready():
    return True


@pytest.fixture
def client():
    return TestClient(app)
