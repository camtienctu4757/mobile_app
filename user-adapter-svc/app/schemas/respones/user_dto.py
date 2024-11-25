from pydantic import BaseModel
from uuid import UUID
from typing import List, Any

class UserOut(BaseModel):
    user_uuid: UUID
    username: str
    password: str
    email: str
    phone_number: str
    firstname:str
    lastname:str
    is_enabled: bool
    class Config:
        from_attributes = True

class RoleOut(BaseModel):
    role_name: str
    class Config:
        from_attributes = True

class UserWithRole(BaseModel):
    user: UserOut
    roles: List[str]
    class Config:
        from_attributes = True
        

class UserOutRoles(BaseModel):
    user_uuid: UUID
    username: str
    password: str
    email: str
    phone_number: str
    firstname:str
    lastname:str
    is_enabled: bool
    roles:List[str]
    class Config:
        from_attributes = True

class BaseOut(BaseModel):
    status: str
    message: str