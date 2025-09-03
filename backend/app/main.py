from fastapi import FastAPI
from app.logging_conf import setup_json_logging
from app.settings import settings
from app.middleware.request_id import RequestIdMiddleware
from app.middleware.security import add_security
from app.middleware.rate_limit import rate_limiter
from app.api.v1.router import api


def create_app() -> FastAPI:
    setup_json_logging(settings.log_level)
    app = FastAPI(title="Coulisses Crew API", version="0.1.0")
    app.add_middleware(RequestIdMiddleware)
    add_security(
        app,
        [o.strip() for o in settings.cors_origins.split(",") if o.strip()],
    )
    app.middleware("http")(
        rate_limiter(
            settings.rate_limit_default,
            settings.rate_limit_window_seconds,
        )
    )
    app.include_router(api)
    return app


app = create_app()
