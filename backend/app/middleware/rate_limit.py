import time
from fastapi import Request, HTTPException
from typing import Callable


class SimpleSlidingWindow:
    def __init__(self, limit: int, window_s: int):
        self.limit = limit
        self.window = window_s
        self.hits: dict[str, list[float]] = {}

    def hit(self, key: str) -> bool:
        now = time.time()
        window = self.hits.get(key, [])
        window = [t for t in window if now - t <= self.window]
        if len(window) >= self.limit:
            return False
        window.append(now)
        self.hits[key] = window
        return True


def rate_limiter(limit: int, window_s: int) -> Callable:
    sw = SimpleSlidingWindow(limit, window_s)

    async def middleware(request: Request, call_next):
        client = request.client
        key = client.host if client else "unknown"
        if not sw.hit(key):
            raise HTTPException(status_code=429, detail="Rate limit exceeded")
        return await call_next(request)

    return middleware
