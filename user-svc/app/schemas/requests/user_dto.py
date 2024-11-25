from pydantic import BaseModel
from typing import Optional
from uuid import UUID
from datetime import datetime, date, time
class TokenUser(BaseModel):
    user_id:Optional[UUID] = None
    access_token: str
    class Config:
        from_attributes = True

class Absent_infor(BaseModel):
    absence_date: date
    reason: Optional[str] = None
    service_uuid: UUID
    start_time: time
    end_time: time
    class Config:
        from_attributes = True
 