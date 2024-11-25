from utils.constants.enum import Tags
from fastapi import APIRouter
import sys
sys.path.append('/')
router = APIRouter()


@router.get("/healthcheck", tags=[Tags.HealthChecks.value])
def health_check():
    return {"status": "healthy"}
