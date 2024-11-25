
from enum import Enum


class Tags(Enum):
    Files: str = "Files"
    HealthChecks: str = "HealthChecks"


class ApiVersion(Enum):
    v1: str = "/api/v1"
    v2: str = "/api/v2"
    v3: str = "/api/v3"
    v4: str = "/api/v4"
