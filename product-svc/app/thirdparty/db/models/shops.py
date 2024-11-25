from sqlalchemy import Column, String, Integer, func,TIMESTAMP,DECIMAL,Time
import uuid
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy import Column, String, Integer,ForeignKey
from thirdparty.db.sessions import PostgresDBManager
from thirdparty.db.models.users import User

class Shop(PostgresDBManager.Base):
    __tablename__ = "shops"
    shop_uuid = Column(UUID(as_uuid=True), primary_key=True,
                        default=uuid.uuid4, unique=True, nullable=False)
    shop_name = Column(String, nullable=False)
    owner_id = Column(UUID,ForeignKey("users.user_uuid",ondelete="CASCADE"), nullable=False)
    address = Column(String, nullable=False)
    phone = Column(String, nullable=False)
    email = Column(String, nullable=False)
    created_at = Column(TIMESTAMP, server_default=func.now(), nullable=False)
    updated_at = Column(TIMESTAMP, server_default=func.now(), nullable=False)
    close_time = Column(Time)
    open_time = Column(Time)
    