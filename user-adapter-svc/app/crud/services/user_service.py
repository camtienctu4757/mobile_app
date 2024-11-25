<<<<<<< HEAD
=======
<<<<<<< HEAD
from crud.repositories.user_repository import UserRepository
from crud.irepositories.iuser_repository import IUserRepository
import sys

=======
>>>>>>> camtienv7
from thirdparty.db.models.users import User
from crud.repositories.user_repository import UserRepository
from crud.irepositories.iuser_repository import IUserRepository
from uuid import UUID
import sys
from loguru import logger
<<<<<<< HEAD
=======
>>>>>>> camtienv6
>>>>>>> camtienv7
sys.path.append('/')
sys.tracebacklimit = 0


class UserService(IUserRepository):
    def __init__(self, user_repository: UserRepository):
        self.__user_repository = user_repository

    async def get_all(self, db) -> list[object]:
        return await self.__user_repository.get_all(db=db)
    
    async def get_by_username(self, username,db) -> object:
        return await self.__user_repository.get_by_username(user_name=username, db=db)
    async def get_user_byid(self, user_id,db) -> object:
        return await self.__user_repository.get_user_byid(user_id=user_id, db=db)
    
    async def get_by_email(self, email,db) -> object:
        return await self.__user_repository.get_by_email(email=email, db=db)
    
    async def count_user(self,db) -> object:
        return await self.__user_repository.count_user(db=db)