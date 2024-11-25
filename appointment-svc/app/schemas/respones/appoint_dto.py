from pydantic import BaseModel
from uuid import UUID
from datetime import datetime,date, time

class BookingOut(BaseModel):
    appointment_uuid: UUID
    service_name: str
    price: float
    duration: int
    address: str
    shop_name: str
    slot_date: date
    start_time: time
    class Config:
        from_attributes = True

