from crud.irepositories.iproduct_repository import IProductRepository
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from thirdparty.db.models.products import Product
from uuid import UUID
from loguru import logger
import sys
sys.path.append('/')
sys.tracebacklimit = 0


class ProductRepository(IProductRepository):
    async def get(self, db: AsyncSession, product_id: UUID) -> list[object]:
        try:
            return (await db.scalars(select(Product).where(Product.product_id == product_id))).all()
        except Exception as e:
            logger.error(f"{e}")

    async def get_all(self, db: AsyncSession) -> list[object]:
        try:
            return (await db.scalars(select(Product))).all()
        except Exception as e:
            logger.error(f"{e}")

    async def add(self, db: AsyncSession, product):
        try:
            db_item = Product(**product.dict())
            db.add(db_item)
            await db.commit()
            await db.refresh(db_item)
            return db_item
        except Exception as e:
            logger.error(f"{e}")

    def update(self, db: AsyncSession, product) -> object:
        pass
