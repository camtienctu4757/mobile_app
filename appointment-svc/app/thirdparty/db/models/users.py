from sqlalchemy import Column, String, Integer,Enum, func,TIMESTAMP,Boolean
import uuid
from sqlalchemy.dialects.postgresql import UUID
from thirdparty.db.sessions import PostgresDBManager

class User(PostgresDBManager.Base):
    __tablename__ = "users"
    user_uuid = Column(UUID(as_uuid=True), primary_key=True,
                        default=uuid.uuid4, unique=True, nullable=False)
    username = Column(String, nullable=False)
    password = Column(String, nullable=False)
    email = Column(String, nullable=False)
    phone_number = Column(String, nullable=False)
    created_at = Column(TIMESTAMP, server_default=func.now(), nullable=False)
    updated_at = Column(TIMESTAMP, server_default=func.now(), nullable=False)
    firstname = Column(String)
    lastname = Column(String)
    is_enabled = Column(Boolean, nullable=False, default=True)


