from pydantic import BaseModel
import os

class Settings(BaseModel):
    app_env: str = os.getenv("APP_ENV","dev")
    log_level: str = os.getenv("LOG_LEVEL","INFO")
    api_host: str = os.getenv("API_HOST","127.0.0.1")
    api_port: int = int(os.getenv("API_PORT","8000"))
    cors_origins: str = os.getenv("CORS_ORIGINS","http://127.0.0.1:5173")
    db_host: str = os.getenv("DB_HOST","127.0.0.1")
    db_port: int = int(os.getenv("DB_PORT","5432"))
    db_name: str = os.getenv("DB_NAME","cc")
    db_user: str = os.getenv("DB_USER","cc")
    db_password: str = os.getenv("DB_PASSWORD","devpass")
    redis_host: str = os.getenv("REDIS_HOST","127.0.0.1")
    redis_port: int = int(os.getenv("REDIS_PORT","6379"))
    rate_limit_default: int = int(os.getenv("RATE_LIMIT_DEFAULT","60"))
    rate_limit_window_seconds: int = int(os.getenv("RATE_LIMIT_WINDOW_SECONDS","60"))

    @property
    def database_uri(self) -> str:
        return f"postgresql+psycopg2://{self.db_user}:{self.db_password}@{self.db_host}:{self.db_port}/{self.db_name}"

settings = Settings()
