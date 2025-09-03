from typing import Any


def clamp_limit(limit: int, default: int = 50, max_limit: int = 200) -> int:
    if limit is None:
        return default
    return max(1, min(limit, max_limit))


def paginate(items: list[Any], limit: int, offset: int) -> dict:
    limit = clamp_limit(limit)
    offset = max(0, offset or 0)
    return {
        "items": items[offset : offset + limit],
        "total": len(items),
        "limit": limit,
        "offset": offset,
    }
