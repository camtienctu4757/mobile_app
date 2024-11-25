from crud.repositories.product_repository import ProductRepository
from crud.irepositories.iproduct_repository import IProductRepository
from uuid import UUID
import sys
from loguru import logger
sys.path.append('/')
sys.tracebacklimit = 0


class ProductService(IProductRepository):
    def __init__(self, _product_repository: ProductRepository):
        self.__product_repository = _product_repository

    async def get(self, db, product_id: UUID) -> list[object]:
        try:
            return await self.__product_repository.get(db=db, product_id=product_id)
        except Exception as e:
            logger.error(f"{e}")

    async def get_all(self, db) -> list[object]:
        try:
            return await self.__product_repository.get_all(db=db)
        except Exception as e:
            logger.error(f"{e}")

    async def add(self, db, product) -> object:
        try:
            return await self.__product_repository.add(db, product)
        except Exception as e:
            logger.error(f"{e}")

    def update(self, db, product):
        raise NotImplementedError
    
    def test_consumer(self, msg):
        logger.info(f"message in fuction service {msg.value().decode('utf-8')}")
        # logger.info(f"message in fuction service {msg.value().decode('utf-8')}")

