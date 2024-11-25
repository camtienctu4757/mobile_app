from pydantic import BaseModel
from uuid import UUID
from typing import Optional

class UserOut(BaseModel):
    user_uuid: UUID
    username: str
    email: str
    phone_number: str
    class Config:
        from_attributes = True



class TokenUser(BaseModel):
    user_uuid:Optional[UUID] = None
    access_token: str
    class Config:
        from_attributes = True

# eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZTQyNGRiZmEtM2ZlNC00YzE2LTkyOTAtNjEwMWZkZGE3ZjkyIiwiZXhwIjoxNzMyMzMxODAyfQ.wMmzLChObtp9gmsAuiqi5XKSazvIov4EUiXXc1oKfyQ
class BaseOut(BaseModel):
    status: str
    message: str