from typing import Optional
from pydantic import BaseModel,EmailStr
from datetime import datetime,time
from uuid import UUID
class shopbase(BaseModel):
    shop_name: str
    address: str
    phone: str
    email: str
    class Config:
        from_attributes = True
    
class shopin(shopbase):
    pass

class ShopUpdate(BaseModel):
    shop_uuid: str
    shop_name: Optional[str] = None
    address:Optional[str] = None
    phone: Optional[str] = None
    email: Optional[str] = None
    close_time:Optional[str] = None
    open_time:Optional[str] = None
