from fastapi import APIRouter

router = APIRouter()


@router.get("/meta/version")
def version():
    return {"name": "Coulisses Crew API", "version": "0.1.0"}
