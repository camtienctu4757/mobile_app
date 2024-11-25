from sqlalchemy import Column, String, Integer, func,TIMESTAMP,DECIMAL
import uuid
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy import Column, String, Integer, Float, DateTime,text,ForeignKey
from thirdparty.db.sessions import PostgresDBManager
from sqlalchemy.orm import relationship

class Shop(PostgresDBManager.Base):
    __tablename__ = "shops"
    shop_uuid = Column(UUID(as_uuid=True), primary_key=True,
                        default=uuid.uuid4, unique=True, nullable=False)
    shop_name = Column(String, nullable=False)
    owner_id = Column(Integer,ForeignKey("User.user_uuid",ondelete="CASCADE"), nullable=False)
    address = Column(String, nullable=False)
    phone = Column(String, nullable=False)
    email = Column(String, nullable=False)
    created_at = Column(TIMESTAMP, server_default=func.now(), nullable=False)
    updated_at = Column(TIMESTAMP, server_default=func.now(), nullable=False)
    