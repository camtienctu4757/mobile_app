from pydantic import BaseModel
from uuid import UUID


class Product(BaseModel):
    service_name: str
    price: float
    duration: int
    description: str
    

