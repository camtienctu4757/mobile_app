from typing import Optional
from pydantic import BaseModel,EmailStr
from datetime import datetime
from datetime import time
from uuid import UUID
class shopbase(BaseModel):
    shop_name: str
    address: str
    phone: str
    email: str
    open_time: time
    close_time: time
    class Config:
        from_attributes = True

class shopout(shopbase):
    shop_uuid: UUID
    pass
