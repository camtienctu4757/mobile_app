from thirdparty.db.models.users import User
from crud.repositories.user_repository import UserRepository
from crud.irepositories.iuser_repository import IUserRepository
import sys
import json
import asyncio
from loguru import logger
sys.path.append('/')
sys.tracebacklimit = 0
class UserService(IUserRepository):
    def __init__(self, user_repository: UserRepository):
        self.__user_repository = user_repository

    async def get(self, db, userdata) -> User:
        return await self.__user_repository.get(db=db, userdata=userdata)
    

    async def add_user(self,db_read,db_write,email, username, password, phone ) -> User:
        try:
            return await self.__user_repository.add_user(db_write=db_write,db_read = db_read, email= email, username=username, password=password, phone = phone)
        except Exception as e:
            logger.error(f"{e}")
    
    
    async def create_employee_absent(self,db, absent_infor) -> object:
        try:
            return await self.__user_repository.create_employee_absent(db = db, absent_infor = absent_infor)
        except Exception as e:
            logger.error(f"{e}")
    
    async def delete(self,db_read,db_write, user_id) -> list[object]:
        try:
            return await self.__user_repository.delete(db_read=db_read,db_write=db_write, user_id = user_id)
        except Exception as e:
            logger.error(f"{e}")


    async def update_user(self, db_read, db_write,user_id,email,phone,username,firstname,lastname) -> list[object]:
        try:
            return await self.__user_repository.update_user(db_read=db_read, db_write= db_write, user_id=user_id,email=email,phone=phone,username=username,firstname=firstname,lastname=lastname)
        except Exception as e:
            logger.error(f"{e}")

    async def update_user_pass(self, db_read, db_write,user_id,user_pass):
        try:
            return await self.__user_repository.update_user_pass(db_read=db_read, db_write= db_write, user_id=user_id,user_pass = user_pass)
        except Exception as e:
            logger.error(f"{e}")
            
    # async def update_role(self, message,db_read,db_write):
    #     try:
    #         data = message.value()
    #         decoded_data = data.decode('utf-8')
    #         parsed_data = json.loads(decoded_data)
    #         res = await self.__user_repository.update_role(user_id=parsed_data['user_id'],db_read=db_read,db_write=db_write,role=parsed_data['role'])
    #     except Exception as e:
    #         logger.error(f"{e}")
    # def run_consumer(self):
    #     asyncio.run(KafkaExcecute.consume(self.update_role,['tienlab'],'test'))

    
