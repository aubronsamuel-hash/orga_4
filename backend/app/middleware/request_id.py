import uuid
from starlette.middleware.base import BaseHTTPMiddleware
from starlette.requests import Request
from starlette.responses import Response

HEADER = "x-request-id"

class RequestIdMiddleware(BaseHTTPMiddleware):
    async def dispatch(self, request: Request, call_next):
        req_id = request.headers.get(HEADER) or str(uuid.uuid4())
        response: Response = await call_next(request)
        response.headers[HEADER] = req_id
        return response
