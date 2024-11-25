from pydantic import BaseModel
from uuid import UUID
from typing import List

class ProductOut(BaseModel):
    service_uuid: UUID
    service_name: str
    price: float
    duration: int
    description: str
    shop_uuid: UUID
    catalog_uuid: UUID
    class Config:
        from_attributes = True
class FileOut(BaseModel):
    file_uuid:UUID
    folder_path:str
    file_name: str
    class Config:
        from_attributes = True

class ServiceWithImages(BaseModel):
    service: ProductOut
    imgs: List[dict]
    class Config:
        from_attributes = True
        


class BaseOut(BaseModel):
    status: str
    message: str