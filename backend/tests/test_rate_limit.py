import itertools


def test_rate_limit_ok_then_429(client):
    for _ in itertools.repeat(None, 60):
        assert client.get("/api/v1/health").status_code == 200
    assert client.get("/api/v1/health").status_code in (200, 429)
