from crud.irepositories.ishop_repository import IShopRepository
from sqlalchemy import select, update, func,and_
from sqlalchemy.ext.asyncio import AsyncSession
from thirdparty.db.models.shops import Shop
from datetime import datetime
from thirdparty.db.models.roles import UserRoles,Role
from uuid import UUID
from thirdparty.kafka.executes import KafkaExcecute
import json
from loguru import logger
import sys

sys.path.append("/")
sys.tracebacklimit = 0


class ShopRepository(IShopRepository):
    async def get(self, db: AsyncSession, shop_id: UUID) -> object:
        try:
            return (
                await db.scalars(select(Shop).where(Shop.shop_uuid == shop_id))
            ).first()
        except Exception as e:
            logger.error(f"{e}")

    async def get_shopby_userid(self, db: AsyncSession, owner_id: UUID) -> list[object]:
        try:
            return (
                await db.scalars(select(Shop).where(Shop.owner_id == owner_id))
            ).all()
        except Exception as e:
            logger.error(f"{e}")

    async def get_nearby_shop(
        self, db: AsyncSession, lat: float, long: float
    ) -> list[object]:
        try:
            query = select(Shop).where(
                (
                    6371
                    * func.acos(
                        func.cos(func.radians(lat))
                        * func.cos(func.radians(Shop.latitude))
                        * func.cos(func.radians(Shop.longitude) - func.radians(long))
                        + func.sin(func.radians(lat))
                        * func.sin(func.radians(Shop.latitude))
                    )
                    < 10
                )  # 10 km
            )
            return (await db.scalars(query)).all()

        except Exception as e:
            logger.error(f"{e}")

    async def delete_shop(self, db: AsyncSession, shop_id: UUID, user_id: UUID):
        try:
            shop = (
                await db.scalars(select(Shop).where(Shop.shop_uuid == shop_id))
            ).first()
            if shop is not None:
                if shop.owner_id != user_id:
                    return False
                await db.delete(shop)
                await db.commit()
                return True
            return False
        except Exception as e:
            logger.error(f"{e}")

    async def update_shop(self, db: AsyncSession, shop_info, user_id: UUID):
        try:
            shop = (
                await db.scalars(
                    select(Shop).where(Shop.shop_uuid == shop_info.shop_uuid)
                )
            ).first()
            if shop is not None:
                shop_name = (
                    shop_info.shop_name
                    if (shop_info.shop_name is not None)
                    else shop.shop_name
                )
                updated_at=datetime.now()
                address = shop_info.address if (shop_info.address is not None) else shop.address
                email=(
                            shop_info.email
                            if (shop_info.email is not None)
                            else shop.email
                        )      
                phone=(
                            shop_info.phone
                            if (shop_info.phone is not None)
                            else shop.phone
                        )
                latitude=(
                            shop_info.latitude
                            if (shop_info.latitude is not None)
                            else shop.latitude
                        )
                
                longitude=(
                            shop_info.longitude
                            if (shop_info.longitude is not None)
                            else shop.longitude
                        )
                open_time=(
                            shop_info.open_time
                            if (shop_info.open_time is not None)
                            else shop.open_time
                        )
                close_time=(
                            shop_info.close_time
                            if (shop_info.close_time is not None)
                            else shop.close_time
                        )
                if shop.owner_id != user_id:
                    return False
                result = (
                    update(Shop)
                    .where(Shop.shop_uuid == shop_info.shop_uuid)
                    .values(
                        shop_name= shop_name,
                        updated_at= updated_at,
                        address= address,
                        email= email,
                        phone = phone,
                        latitude = latitude,
                        longitude = longitude,
                        open_time = open_time,
                        close_time = close_time
                        
                    )
                    .execution_options(synchronize_session=False)
                )
                await db.execute(result)
                await db.commit()
                return True
            return False
        except Exception as e:
            logger.error(f"{e}")

    async def create_shop(self, db: AsyncSession, shop: Shop, user_id:UUID):
        try:
            new_shop = shop
            new_shop.created_at = datetime.now()
            shop_check = (await db.scalars(select(Shop).where(and_(Shop.shop_name == new_shop.shop_name, shop.owner_id == new_shop.owner_id)))).first()
            if shop_check:
                return
            db.add(new_shop)
            role_id = (await db.scalars(select(Role.role_uuid).where(Role.role_name == 'shop'))).first()
            if role_id is not None :
                user_role = (await db.scalars(select(UserRoles).where(and_(UserRoles.user_uuid == user_id,UserRoles.role_uuid == role_id)))).first()
                if not user_role :
                    role = UserRoles(user_uuid = user_id, role_uuid = role_id)
                    db.add(role)
                    await db.commit()
                    await db.refresh(new_shop)
                    return new_shop
            await db.commit()
            await db.refresh(new_shop)
            return new_shop
        except Exception as e:
            logger.error(f"{e}")
    async def update_role(self,user_id,role,db_read: AsyncSession, db_write :AsyncSession):
        try:
            role_id = (await db_read.scalars(select(Role).where(Role.role_name == role))).first()
            if role is not None :
                user_role = (await db_read.scalars(select(UserRoles).where(and_(UserRoles.user_uuid == user_id,UserRoles.role_uuid == role_id)))).first()
                if user_role is not None:
                    return {"mess":"this user was a owner of a shop before"}
                logger.error(f"{role_id}, type {type(role_id.role_uuid)}")
                role = UserRoles(user_uuid = user_id, role_uuid = role_id.role_uuid)
                db_write.add(role)
                await db_write.commit()
                await db_write.refresh(role)
                return role
            return {"mess":"false"}
        except Exception as e:
            logger.error(f"{e}")

