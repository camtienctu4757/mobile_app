from sqlalchemy import Column, String, Integer, DateTime,text,ForeignKey
import uuid
from sqlalchemy.dialects.postgresql import UUID
from thirdparty.db.sessions import PostgresDBManager
import sys
sys.path.append('/')

class Status(PostgresDBManager.Base):
    __tablename__ ="status"
    id_status = Column(UUID(as_uuid= True), primary_key= True, default=uuid.uuid4, unique=True, nullable=False)
    status_name = Column(String,nullable=False)

class Appointment(PostgresDBManager.Base):
    __tablename__ = "appointments"
    appointment_uuid = Column(UUID(as_uuid=True), primary_key=True,default=uuid.uuid4, unique=True, nullable=False)
    user_uuid = Column(UUID(as_uuid=True),ForeignKey("users.user_uuid", ondelete="CASCADE"), nullable=False)
    status = Column(UUID, (ForeignKey("status.id_status",ondelete="CASCADE")),nullable=False)
    timeslot_uuid = Column(UUID,(ForeignKey("time_slots.slot_uuid",ondelete="CASCADE")), nullable=False)
    created_at = Column(DateTime, default=text("now()"))
    updated_at = Column(DateTime, default=text("now()"))
