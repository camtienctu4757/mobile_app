from pydantic import BaseModel
from uuid import UUID
from typing import Optional

class fileout(BaseModel):
    file_uuid: UUID
    file_name: str
    folder_path: str
    class Config:
        from_attributes = True
