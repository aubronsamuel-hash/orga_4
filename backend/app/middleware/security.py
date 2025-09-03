from starlette.middleware.cors import CORSMiddleware
from fastapi import FastAPI


def add_security(app: FastAPI, origins: list[str]) -> None:
    app.add_middleware(
        CORSMiddleware,
        allow_origins=origins,
        allow_methods=["*"],
        allow_headers=["*"],
    )

    @app.middleware("http")
    async def add_headers(request, call_next):
        resp = await call_next(request)
        resp.headers["x-content-type-options"] = "nosniff"
        resp.headers["x-frame-options"] = "DENY"
        resp.headers["x-xss-protection"] = "1; mode=block"
        return resp
