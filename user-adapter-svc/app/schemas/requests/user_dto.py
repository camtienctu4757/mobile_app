from pydantic import BaseModel
from uuid import UUID


class Product(BaseModel):
    name: str
