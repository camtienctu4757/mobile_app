from sqlalchemy import Column, String, Integer, Float, DateTime,text,ForeignKey,Boolean
import uuid
from sqlalchemy.orm import relationship
from sqlalchemy.dialects.postgresql import UUID
from thirdparty.db.sessions import PostgresDBManager
from sqlalchemy import text, func
from datetime import datetime
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
    def to_dict(self):
        return {
            "service_uuid": str(self.service_uuid),
            "service_name": self.service_name,
            "shop_uuid": str(self.shop_uuid),
            "catalog_uuid": str(self.catalog_uuid),
            "description": self.description,
            "price": self.price,
            "duration": self.duration,
            "employees": self.employees,
            "created_at": self.created_at,
            "updated_at": self.updated_at,
            "is_enable": self.is_enable,
        }

class Catalog(PostgresDBManager.Base):
    __tablename__ = "catalog"
    catalog_uuid =  Column(UUID(as_uuid=True), primary_key=True,
                        default=uuid.uuid4, unique=True, nullable=False)
    catalog_name = Column(String, nullable=False)
    


