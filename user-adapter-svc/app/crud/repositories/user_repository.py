from crud.irepositories.iuser_repository import IUserRepository
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from thirdparty.db.models.users import User
from thirdparty.db.models.roles import UserRoles
from thirdparty.db.models.roles import Role
<<<<<<< HEAD
=======
<<<<<<< HEAD
from loguru import logger
=======
>>>>>>> camtienv7
from schemas.respones.user_dto import UserOut,UserWithRole, UserOutRoles
from uuid import UUID
from loguru import logger
from utils.constants.message import Message
<<<<<<< HEAD
=======
>>>>>>> camtienv6
>>>>>>> camtienv7
from utils.helpers.mapper import Mapper
import sys
from sqlalchemy import func
sys.path.append("/")


class UserRepository(IUserRepository):
    
    async def get_all(self, db: AsyncSession) -> list[object]:
        try:
            userlist = (await db.scalars(select(User))).all()
            result = []
            for user in userlist:
                roles = (await db.scalars(select(Role)
            .join(UserRoles, Role.role_uuid == UserRoles.role_uuid)
            .where(UserRoles.user_uuid == user.user_uuid))).all()
                roles_list = [role.role_name for role in roles]
                result.append(Mapper.mapper_usermodel_to_userwithrole(user = user, role_list=roles_list))
            return result
        except Exception as e:
            logger.error(f"{e}")

    async def get_by_username(self, user_name: str, db: AsyncSession) -> object:
        try:
            user = (await db.scalars(select(User).where(User.username == user_name))).first()
            if user is not None:
                roles = (await db.scalars(select(Role)
            .join(UserRoles, Role.role_uuid == UserRoles.role_uuid)
            .where(UserRoles.user_uuid == user.user_uuid))).all()
                roles_list = [role.role_name for role in roles]
                return [Mapper.mapper_usermodel_to_userwithrole(user = user,role_list=roles_list)]
        except Exception as e:
            logger.error(f"{e}")

    async def get_user_byid(self, user_id: str, db: AsyncSession) -> object:
        try:
            user = (await db.scalars(select(User).where(User.user_uuid == user_id))).first()
            if user is not None:
                roles = (await db.scalars(select(Role)
            .join(UserRoles, Role.role_uuid == UserRoles.role_uuid)
            .where(UserRoles.user_uuid == user.user_uuid))).all()
                roles_list = [role.role_name for role in roles]
                return [Mapper.mapper_usermodel_to_userwithrole(user = user,role_list=roles_list)]
        except Exception as e:
            logger.error(f"{e}")
    async def get_by_email(self, email: str, db: AsyncSession) -> object:
        try:
            user = (await db.scalars(select(User).where(User.email == email))).first()
            if user is not None:
                roles = (await db.scalars(select(Role)
            .join(UserRoles, Role.role_uuid == UserRoles.role_uuid)
            .where(UserRoles.user_uuid == user.user_uuid))).all()
                roles_list = [role.role_name for role in roles]
                return [Mapper.mapper_usermodel_to_userwithrole(user = user,role_list=roles_list)]
        except Exception as e:
            logger.error(f"{e}")
        
    async def count_user(self, db: AsyncSession) -> object:
        try:
            result = await db.scalar(select(func.count()).select_from(User))
            print (result)
            return result
        except Exception as e:
            logger.error(f"{e}")

    # def delete(self, user_id: UUID) -> None:
    #     return
