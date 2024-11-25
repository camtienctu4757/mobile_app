from pydantic import BaseModel
from uuid import UUID


class Booking(BaseModel):
    user_uuid: UUID
    timeslot_uuid: UUID
    

# EXPLAIN SELECT * FROM users WHERE user_uuid='c340af68-957c-43dd-84f2-5d766d84033';