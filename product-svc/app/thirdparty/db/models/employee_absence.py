from sqlalchemy import Column, TIMESTAMP, String,UUID,ForeignKey,Date
import uuid
from sqlalchemy.orm import relationship
from thirdparty.db.sessions import PostgresDBManager
from sqlalchemy import text, func
import sys
sys.path.append('/')
class EmployeeAbsences(PostgresDBManager.Base):
    __tablename__ = "employee_absences"
    absences_uuid = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4, nullable=False)
    absence_date = Column(Date, nullable=False)
    reason = Column(String(255))
    service_uuid = Column(UUID(as_uuid=True), ForeignKey('services.service_uuid'), nullable=False)
    start_time = Column(TIMESTAMP(timezone=False), nullable=False)
    end_time = Column(TIMESTAMP(timezone=False), nullable=False)