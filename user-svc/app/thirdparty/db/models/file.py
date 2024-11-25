from sqlalchemy import Column, String,UUID,ForeignKey
import uuid
from thirdparty.db.sessions import PostgresDBManager
class ServiceFile(PostgresDBManager.Base):
    __tablename__ = "service_files"
    file_uuid = Column(UUID(as_uuid=True), primary_key=True,
                        default=uuid.uuid4, unique=True, nullable=False)
    service_uuid = Column(UUID(as_uuid=True), ForeignKey("Service.service_uuid",ondelete="CASCADE"),nullable=False,)
    file_name = Column(String, nullable=False)
    
class ShopFile(PostgresDBManager.Base):
    __tablename__ = "shop_files"
    file_uuid = Column(UUID(as_uuid=True), primary_key=True,
                        default=uuid.uuid4, unique=True, nullable=False)
    shop_uuid = Column(UUID(as_uuid=True), ForeignKey("Shop.shop_uuid",ondelete="CASCADE"),nullable=False,)
    file_name = Column(String, nullable=False)

class UserFile(PostgresDBManager.Base):
    __tablename__ = "user_files"
    file_uuid = Column(UUID(as_uuid=True), primary_key=True,
                        default=uuid.uuid4, unique=True, nullable=False)
    user_uuid = Column(UUID(as_uuid=True), ForeignKey("User.user_uuid",ondelete="CASCADE"),nullable=False,)
    file_name = Column(String, nullable=False)