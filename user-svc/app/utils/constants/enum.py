
from enum import Enum


class Tags(Enum):
    Products: str = "Products"
    HealthChecks: str = "HealthChecks"
    Users: str = "Users"
    Shops:str = "Shops"
    Appointment: str = "Appointments"
    Employees: str = "Employees"
    Notifications: str = "Notifications"


class ApiVersion(Enum):
    v1: str = "/api/v1"
    v2: str = "/api/v2"
    v3: str = "/api/v3"
    v4: str = "/api/v4"
