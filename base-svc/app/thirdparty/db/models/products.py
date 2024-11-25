from sqlalchemy import Column, String, Integer
import uuid
from sqlalchemy.dialects.postgresql import UUID

from thirdparty.db.sessions import PostgresDBManager
import sys
sys.path.append('/')
<<<<<<< HEAD


class Product(PostgresDBManager.Base):
    __tablename__ = "product_test"

=======
class Product(PostgresDBManager.Base):
    __tablename__ = "products"
>>>>>>> camtienv7
    product_id = Column(UUID(as_uuid=True), primary_key=True,
                        default=uuid.uuid4, unique=True, nullable=False)
    name = Column(String)
