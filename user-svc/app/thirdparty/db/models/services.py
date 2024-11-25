from sqlalchemy import Column, String, Integer, Float, DateTime,text,ForeignKey,Boolean
import uuid
from sqlalchemy.orm import relationship
from sqlalchemy.dialects.postgresql import UUID
from thirdparty.db.sessions import PostgresDBManager
from sqlalchemy import text, func
import sys
sys.path.append('/')

class Service(PostgresDBManager.Base):
    __tablename__ = "services"
    service_uuid =  Column(UUID(as_uuid=True), primary_key=True,
                        default=uuid.uuid4, unique=True, nullable=False)
    service_name =  Column(String, nullable=False)
    shop_uuid = Column((UUID(as_uuid=True)), ForeignKey("shops.shop_uuid",ondelete="CASCADE"),nullable=False)
    catalog_uuid = Column((UUID(as_uuid=True)), ForeignKey("catalog.catalog_uuid",ondelete="CASCADE"),nullable=False, )
    description = Column(String, nullable=False)
    price = Column(Float, nullable=False)
    duration = Column(Integer, nullable=False)
    employees = Column(Integer, nullable=False)
    created_at = Column(DateTime, server_default=func.now(), nullable=False)
    updated_at = Column(DateTime, server_default=func.now(), onupdate=func.now(), nullable=False)
    is_enable = Column(Boolean, nullable=False, default=True)
class Catalog(PostgresDBManager.Base):
    __tablename__ = "catalog"
    catalog_uuid =  Column(UUID(as_uuid=True), primary_key=True,
                        default=uuid.uuid4, unique=True, nullable=False)
    catalog_name = Column(String, nullable=False)
    


