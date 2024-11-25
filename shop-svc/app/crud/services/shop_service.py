from crud.repositories.shop_repository import ShopRepository
from crud.irepositories.ishop_repository import IShopRepository
from uuid import UUID
import sys
import json
from loguru import logger
from thirdparty.kafka.executes import KafkaExcecute
import asyncio
sys.path.append('/')
sys.tracebacklimit = 0


class ShopService(IShopRepository):
    def __init__(self, _product_repository: ShopRepository):
        self.__product_repository = _product_repository

    async def get(self, db, shop_id: UUID) -> list[object]:
        try:
            return await self.__product_repository.get(db=db, shop_id= shop_id)
        except Exception as e:
            logger.error(f"{e}")
    async def get_shopby_userid(self, db, owner_id: UUID) -> list[object]:
        try:
            return await self.__product_repository.get_shopby_userid(db=db, owner_id= owner_id)
        except Exception as e:
            logger.error(f"{e}")
    
    async def delete_shop(self, db, shop_id: UUID, user_id:UUID):
        try:
            return await self.__product_repository.delete_shop(db=db, shop_id = shop_id, user_id= user_id)
        except Exception as e:
            logger.error(f"{e}")
    
    async def update_shop(self, db, shop_info, user_id:UUID):
        try:
            return await self.__product_repository.update_shop(db=db, shop_info = shop_info, user_id= user_id)
        except Exception as e:
            logger.error(f"{e}")
    
    async def create_shop(self, db, shop,user_id):
        try:
            return await self.__product_repository.create_shop(db=db, shop= shop,user_id= user_id)
        except Exception as e:
            logger.error(f"{e}")

    async def get_nearby_shop(self, db, lat, long)->list[object]:
        try:
            return await self.__product_repository.get_nearby_shop(db=db,long=long, lat= lat)
        except Exception as e:
            logger.error(f"{e}")
    async def update_role(self, message,db_read,db_write):
        try:
            data = message.value()
            decoded_data = data.decode('utf-8')
            parsed_data = json.loads(decoded_data)
            res = await self.__product_repository.update_role(user_id=parsed_data['user_id'],db_read=db_read,db_write=db_write,role=parsed_data['role'])
        except Exception as e:
            logger.error(f"{e}")
    def run_consumer(self):
        logger.info("Running consumer")
        asyncio.run(KafkaExcecute.consume(self.update_role,['tienlab'],'test'))
