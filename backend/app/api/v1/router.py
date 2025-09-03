from fastapi import APIRouter
from . import health, meta

api = APIRouter(prefix="/api/v1")
api.include_router(health.router, tags=["health"])
api.include_router(meta.router, tags=["meta"])
