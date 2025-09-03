from fastapi import HTTPException


def bad_request(detail: str) -> None:
    raise HTTPException(status_code=400, detail=detail)
