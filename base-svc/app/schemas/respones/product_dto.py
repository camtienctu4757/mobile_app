from pydantic import BaseModel
from uuid import UUID


class Product(BaseModel):
    product_id: UUID
    name: str
