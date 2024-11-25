from sqlalchemy import Column, String,UUID,ForeignKey,DateTime
import uuid
from thirdparty.db.sessions import PostgresDBManager
from sqlalchemy import text, func
from thirdparty.db.models.users import User
from thirdparty.db.models.shops import Shop
from thirdparty.db.models.services import Service
class ServiceFile(PostgresDBManager.Base):
    __tablename__ = "service_files"
    file_uuid = Column(UUID(as_uuid=True), primary_key=True,
                        default=uuid.uuid4, unique=True, nullable=False)
    service_uuid = Column(UUID(as_uuid=True), ForeignKey("services.service_uuid",ondelete="CASCADE"),nullable=False,)
    folder_path = Column(String)
    file_name = Column(String, nullable=False)
    created_at = Column(DateTime, server_default=func.now(), nullable=False)
    
class ShopFile(PostgresDBManager.Base):
    __tablename__ = "shop_files"
    file_uuid = Column(UUID(as_uuid=True), primary_key=True,
                        default=uuid.uuid4, unique=True, nullable=False)
    shop_uuid = Column(UUID(as_uuid=True), ForeignKey("shops.shop_uuid",ondelete="CASCADE"),nullable=False,)
    folder_path = Column(String)
    file_name = Column(String, nullable=False)
    created_at = Column(DateTime, server_default=func.now(), nullable=False)

    def to_dict(self):
        return {
            "file_uuid": str(self.file_uuid),
            "shop_uuid": str(self.shop_uuid),
            "folder_path": self.folder_path,
            "file_name": self.file_name,
            "created_at": self.created_at,
        }

class UserFile(PostgresDBManager.Base):
    __tablename__ = "user_files"
    file_uuid = Column(UUID(as_uuid=True), primary_key=True,
                        default=uuid.uuid4, unique=True, nullable=False)
    user_uuid = Column(UUID(as_uuid=True), ForeignKey("users.user_uuid",ondelete="CASCADE"),nullable=False,)
    folder_path = Column(String)
    file_name = Column(String, nullable=False)
    created_at = Column(DateTime, server_default=func.now(), nullable=False)

    def to_dict(self):
        return {
            "file_uuid": str(self.file_uuid), 
            "user_uuid": str(self.user_uuid),  
            "folder_path": self.folder_path,
            "file_name": self.file_name,
            "created_at": self.created_at
        }


