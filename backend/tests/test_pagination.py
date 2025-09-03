from app.utils.pagination import paginate


def test_paginate_ok():
    out = paginate(list(range(100)), limit=10, offset=5)
    assert out["total"] == 100 and len(out["items"]) == 10 and out["offset"] == 5


def test_paginate_ko_limit():
    out = paginate(list(range(5)), limit=5000, offset=-3)
    assert out["limit"] <= 200 and out["offset"] == 0
