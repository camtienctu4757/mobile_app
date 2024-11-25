from sqlalchemy import Column, Integer, Date, ForeignKey, Time, TIMESTAMP
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base
import uuid
from thirdparty.db.sessions import PostgresDBManager

class TimeSlot(PostgresDBManager.Base):
    __tablename__ = 'time_slots'
    slot_uuid = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4, nullable=False)
    service_uuid = Column(UUID(as_uuid=True), ForeignKey('services.service_uuid'), nullable=True) 
    start_time = Column(Time(timezone=False), nullable=False)
    end_time = Column(Time(timezone=False), nullable=False)
    available_employees = Column(Integer, nullable=False)
    slot_date = Column(Date, nullable=False)
    created_at = Column(TIMESTAMP(timezone=False), server_default='CURRENT_TIMESTAMP')
    updated_at = Column(TIMESTAMP(timezone=False), server_default='CURRENT_TIMESTAMP', onupdate='CURRENT_TIMESTAMP')

