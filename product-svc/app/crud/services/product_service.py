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
        


    async def search(self, db, query) -> list[object]:
        try:
            return await self.__product_repository.search(db,query)
        except Exception as e:
            logger.error(f"{e}")


            
    async def add_product(self, db, product, style,owner_id) -> object:
        try:
            return await self.__product_repository.add_product(db, product, style,owner_id)
        except Exception as e:
            logger.error(f"{e}")



    async def get_bycatalog(self, db, catalog_name) -> object:
        try:
            return await self.__product_repository.get_bycatalog(db,catalog_name)
        except Exception as e:
            logger.error(f"{e}")
    
    async def get_product(self, db, product_id) -> object:
        try:
            return await self.__product_repository.get_product(db,product_id)
        except Exception as e:
            logger.error(f"{e}")

    async def get_byshop(self, db,shop_id) -> object:
        try:
            return await self.__product_repository.get_byshop(db,shop_id)
        except Exception as e:
            logger.error(f"{e}")

    async def add(self, db, product) -> object:
        try:
            return await self.__product_repository.add_product(db, product)
        except Exception as e:
            logger.error(f"{e}")

    async def update(self,db_read,db_write,servicer_id , name , description , price , shop_id ,duration, employee, owner):
        try:
            return await self.__product_repository.update(db_read,db_write,servicer_id, name , description , price , shop_id ,duration, employee, owner)
        except Exception as e:
            logger.error(f"{e}")

    async def delete(self, db_read, db_write, product_id,user_id):
        try:
            return await self.__product_repository.delete(db_read,db_write,product_id,user_id)
        except Exception as e:
            logger.error(f"{e}")