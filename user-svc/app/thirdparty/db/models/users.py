from sqlalchemy import Column, String, Integer,Enum, func,TIMESTAMP,Boolean,ForeignKey
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

    def to_dict(self):
        return {
            "user_uuid": self.user_uuid,
            "email": self.email,
            "firstname": self.firstname,
            "lastname": self.lastname,
            "phone_number": self.phone_number,
            "username": self.username,
            "updated_at": self.updated_at,
        }



class UserTokenNotify(PostgresDBManager.Base):
    __tablename__ = "user_tokens"
    token_uuid = Column(UUID(as_uuid=True), primary_key=True,
                        default=uuid.uuid4, unique=True, nullable=False)
    user_uuid = Column(UUID(as_uuid=True), ForeignKey('users.user_uuid'), nullable=False)
    fcm_token = Column(String, unique=True)
