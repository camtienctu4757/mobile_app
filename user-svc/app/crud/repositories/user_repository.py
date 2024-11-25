from crud.irepositories.iuser_repository import IUserRepository
from sqlalchemy import select, update
from sqlalchemy.ext.asyncio import AsyncSession
from thirdparty.db.models.users import User
from schemas.requests.user_dto import Absent_infor
from sqlalchemy.orm import aliased
from thirdparty.db.models.employee_absence import EmployeeAbsences
from thirdparty.db.models.roles import UserRoles, Role
from thirdparty.db.models.users import User
from thirdparty.db.models.services import Service
from thirdparty.db.models.shops import Shop
from uuid import UUID
import json
from loguru import logger
from utils.helpers.password_process import *
from utils.helpers.oauth2 import *
import sys
sys.path.append("/")


class UserRepository(IUserRepository):
    async def get(self, db: AsyncSession, userdata: UUID) -> User:
        if userdata is not None:
            user = (
                await db.scalars(
                    select(User).where(User.user_uuid == userdata)
                )
            ).first()
            if user is not None:
                return user
        return

    async def login(self, db: AsyncSession, email: str, password: str):
        authUser = (await db.scalars(select(User).where(User.email == email))).first()
        if authUser is None:
            return
        if not verify_password(password, authUser.password):
            return
        access_token = create_token({"id_user": str(authUser.user_uuid)})
        return {"access_token": access_token, "token_type": "bearer"}

    async def update_user(
        self,
        db_read: AsyncSession,
        db_write: AsyncSession,
        user_id: UUID,
        email,
        phone,
        username,
        firstname,
        lastname,
    ):
        try:
            user = (
                await db_read.scalars(select(User).where(User.user_uuid == user_id))
            ).first()
            if user:
                if email is not None:
                    user.email = email
                if firstname is not None:
                    user.firstname = firstname
                if lastname is not None:
                    user.lastname = lastname
                if phone is not None:
                    user.phone_number = phone
                if username is not None:
                    user.username = username
                user.updated_at = datetime.now()
            user = user.to_dict()
            update_user_stament = (
                update(User).where(User.user_uuid == user_id).values(**user)
            ).execution_options(synchronize_session=False)
            await db_write.execute(update_user_stament)
            await db_write.commit()

            return True
        except Exception as e:
            logger.error(e)
            return False

    async def update_user_pass(
        self, db_read: AsyncSession, db_write: AsyncSession, user_id: UUID, user_pass
    ):
        try:
            user = (
                await db_read.scalars(select(User).where(User.user_uuid == user_id))
            ).first()
            if user:
                user.password = hash_password(user_pass)
                user.updated_at = datetime.now()
            user = user.to_dict()
            update_user_stament = (
                update(User).where(User.user_uuid == user_id).values(**user)
            ).execution_options(synchronize_session=False)
            await db_write.execute(update_user_stament)
            await db_write.commit()
            return True
        except Exception as e:
            logger.error(e)
            return False

    async def delete(
        self, db_read: AsyncSession, db_write: AsyncSession, user_id: UUID
    ) -> None:
        try:
            await db_write.execute(
                update(User).where(User.user_uuid == user_id).values(is_enabled=False)
            )
            await db_write.commit()
            shop_alias = aliased(Shop)

            subquery = (
                select(shop_alias.shop_uuid)
                .join(User, shop_alias.owner_id == User.user_uuid)
                .filter(User.user_uuid == user_id)
            )

            stmt = (
                update(Service)
                .where(Service.shop_uuid.in_(subquery))
                .values(is_enable=False)
            ).execution_options(synchronize_session="fetch")

            # Thực thi truy vấn
            await db_write.execute(stmt)
            await db_write.commit()
            return True
        except Exception as e:
            logger.error(e)
            return False

    async def add_user(
        self,
        db_read: AsyncSession,
        db_write: AsyncSession,
        email: str,
        username: str,
        password: str,
        phone: str,
    ) -> User:
        try:
            user = (
                await db_read.scalars(select(User).where(User.email == email))
            ).first()
            if user:
                return
            new_user = User(email=email, username=username, phone_number=phone)
            new_user.password = hash_password(password)
            db_write.add(new_user)
            await db_write.commit()
            await db_write.refresh(new_user)
            result = await self.update_role(user_id=new_user.user_uuid, role='public',db_read=db_read, db_write=db_write)
            if result:
                return new_user
            return
        except Exception as e:
            logger.error(e)

    async def create_employee_absent(
        self, db: AsyncSession, absent_infor: Absent_infor
    ) -> object:
        try:
            absent_infor.start_time = datetime.combine(
                absent_infor.absence_date, absent_infor.start_time
            )
            absent_infor.end_time = datetime.combine(
                absent_infor.absence_date, absent_infor.end_time
            )
            validated_absent_infor_dict = absent_infor.model_dump()
            absent_infor = EmployeeAbsences(**validated_absent_infor_dict)
            db.add(absent_infor)
            await db.commit()
            await db.refresh(absent_infor)
            return absent_infor
        except Exception as e:
            logger.error(e)

    async def update_role(
        self, user_id, role, db_read: AsyncSession, db_write: AsyncSession
    ):
        try:
            role_id = (
                await db_read.scalars(select(Role).where(Role.role_name == role))
            ).first()
            if role is not None:
                role = UserRoles(user_uuid=user_id, role_uuid=role_id.role_uuid)
                db_write.add(role)
                await db_write.commit()
                await db_write.refresh(role)
                return role
            return None
        except Exception as e:
            logger.error(f"{e}")
