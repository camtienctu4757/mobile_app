from sqlalchemy import Column, String,UUID,ForeignKey
import uuid
from thirdparty.db.sessions import PostgresDBManager
class Role(PostgresDBManager.Base):
    __tablename__ = "roles"
    role_uuid = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4, unique=True, nullable=False)
    role_name = Column(String, nullable=False)

class UserRoles(PostgresDBManager.Base):
    __tablename__ = "user_roles"
    user_uuid = Column(UUID(as_uuid=True), ForeignKey("users.user_uuid", ondelete="CASCADE"), primary_key=True)
    role_uuid = Column(UUID(as_uuid=True), ForeignKey("roles.role_uuid", ondelete="CASCADE"), primary_key=True)
