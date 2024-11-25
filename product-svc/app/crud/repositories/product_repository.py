from crud.irepositories.iproduct_repository import IProductRepository
from sqlalchemy import select,update, or_, and_,func
from sqlalchemy.ext.asyncio import AsyncSession
from thirdparty.db.models.services import Service,Catalog
from thirdparty.db.models.file import ServiceFile
from schemas.respones.product_dto import ProductOut,ServiceWithImages,FileOut
from thirdparty.db.models.shops import Shop
from thirdparty.db.models.timeslot import TimeSlot
from thirdparty.db.models.employee_absence import EmployeeAbsences
from datetime import datetime,timedelta
from uuid import UUID
from loguru import logger
from unidecode import unidecode
import sys
sys.path.append('/')
sys.tracebacklimit = 0


class ProductRepository(IProductRepository):
    async def get(self, db: AsyncSession, product_id: UUID) -> list[object]:
        try:
            return (await db.scalars(select(Service).where(Service.service_uuid == product_id and Service.is_enable != False))).all()
        except Exception as e:
            logger.error(f"{e}")

    async def get_bycatalog(self, db: AsyncSession, catalog_name: str) -> list[object]:
        try:
            category = (await db.scalars(select(Catalog.catalog_uuid).where(Catalog.catalog_name == catalog_name))).first()
            service_list =  (await db.scalars(select(Service).where(and_(
            Service.catalog_uuid == category,
            Service.is_enable != False
        )))).all()
            result = []
            if service_list is not None:
                for service in service_list:
                    imgs =[]
                    imgs = (await db.scalars(select(ServiceFile).where(ServiceFile.service_uuid == service.service_uuid))).all()
                    if (imgs is not None):
                        imgs = [(FileOut.model_validate(file.to_dict())).model_dump() for file in imgs]
                    service = ProductOut.model_validate(service)
                    result.append(ServiceWithImages(service=service, imgs=imgs))
                return result
        except Exception as e:
            logger.error(f"{e}")

    async def get_product(self, db: AsyncSession, product_id: UUID) -> list[object]:
        try:
            service =  (await db.scalars(select(Service).where(and_(
            Service.service_uuid == product_id,
            Service.is_enable != False
        )))).first()
            result = []
            if service is not None:
                imgs = (await db.scalars(select(ServiceFile).where(ServiceFile.service_uuid == service.service_uuid))).all()
                if (imgs is not None):
                    imgs = [(FileOut.model_validate(file.to_dict())).model_dump() for file in imgs]
                    result.append(ServiceWithImages(service=service, imgs=imgs))
                return result
        except Exception as e:
            logger.error(f"{e}")
    async def get_byshop(self, db: AsyncSession, shop_id: UUID) -> list[object]:
        try:
            service_list =  (await db.scalars(select(Service).where(and_(Service.shop_uuid == shop_id,Service.is_enable != False)))).all()
            result = []
            if service_list is not None:
                for service in service_list:
                    imgs =[]
                    imgs = (await db.scalars(select(ServiceFile).where(ServiceFile.service_uuid == service.service_uuid))).all()
                    if (imgs is not None):
                        imgs = [(FileOut.model_validate(file.to_dict())).model_dump() for file in imgs]
                    service = ProductOut.model_validate(service)
                    result.append(ServiceWithImages(service=service, imgs=imgs))
                return result
        except Exception as e:
            logger.error(f"{e}")
   
    async def get_all(self, db: AsyncSession) -> list[object]:
        try:
            service_list =  (await db.scalars(select(Service).where(Service.is_enable != False))).all()
            result = []
            for service in service_list:
                imgs =[]
                imgs = (await db.scalars(select(ServiceFile).where(ServiceFile.service_uuid == service.service_uuid))).all()
                if (imgs is not None):
                    imgs = [(FileOut.model_validate(file.to_dict())).model_dump() for file in imgs]
                print(f"{service},{service.catalog_uuid}")
                service = ProductOut.model_validate(service)
                result.append(ServiceWithImages(service=service, imgs=imgs))

            return result
        except Exception as e:
            logger.error(f"{e}")


    async def search(self, db: AsyncSession, query: str) -> list[object]:
        try:
            search_query_without_accent = unidecode(query)
            result = (await db.scalars(select(Service).filter(
        or_(
            func.unaccent( Service.service_name).ilike(f"%{unidecode(search_query_without_accent)}%"),
            func.unaccent( Service.description).ilike(f"%{unidecode(search_query_without_accent)}%"),
        )
    ))).all()

            final = []
            for service in result:
                imgs =[]
                imgs = (await db.scalars(select(ServiceFile).where(ServiceFile.service_uuid == service.service_uuid))).all()
                if (imgs is not None):
                    imgs = [(FileOut.model_validate(file.to_dict())).model_dump() for file in imgs]
                service = ProductOut.model_validate(service)
                final.append(ServiceWithImages(service=service, imgs=imgs))
            return final
        except Exception as e:
            logger.error(f"{e}")




    async def add_product(self, db: AsyncSession, product:Service, style,owner_id:UUID) :
        try:
            category = (await db.scalars(select(Catalog.catalog_uuid).where(Catalog.catalog_name == style))).first()
            shop_owner = (await db.scalars(select(Shop).where(and_(Shop.owner_id == owner_id, Shop.shop_uuid == product.shop_uuid)))).first()
            if shop_owner:
                new_product = product
                new_product.catalog_uuid = category
                new_product.created_at= datetime.now()
                db.add(new_product)
                await db.commit()
                await db.refresh(new_product)
                open_time = shop_owner.open_time
                close_time = shop_owner.close_time
                duration = new_product.duration
                latest_timeslot = (await db.scalars(select(TimeSlot.slot_date).order_by(TimeSlot.created_at.desc()))).first()
                timeslot_duration = 3 
                if latest_timeslot:
                    days_diff = (datetime.now().date() - latest_timeslot).days
                    if days_diff > 0:
                        timeslot_duration = 3 - days_diff
                for i in range(timeslot_duration):
                    current_date = datetime.now() + timedelta(days=i)
                    start_time = datetime.combine(current_date, open_time)
                    end_time = datetime.combine(current_date, close_time)
                    while start_time + timedelta(minutes=duration) <= end_time:
                        absent_employees = await self.count_absent_staff(
                            db, new_product.service_uuid, current_date, start_time
                        )
                        available_employees = max(
                            0, new_product.employees - absent_employees
                        )
                        time_slot = TimeSlot(service_uuid =  new_product.service_uuid,start_time = start_time, end_time = start_time + timedelta(minutes=duration), available_employees = available_employees, slot_date = current_date)
                        db.add(time_slot)
                        start_time += timedelta(minutes=duration)
                await db.commit()
                return new_product
            return None
        except Exception as e:
            logger.error(f"{e}")

    async def count_absent_staff(
        self, db: AsyncSession, service_uuid, slot_date, start_time
    ):
        result = (
            await db.scalars(
                select(func.count())
                .select_from(EmployeeAbsences)
                .where(
                    EmployeeAbsences.service_uuid == service_uuid,
                    EmployeeAbsences.absence_date == slot_date,
                    EmployeeAbsences.start_time <= start_time,
                    EmployeeAbsences.end_time >= start_time,
                )
            )
        ).first()
        return result
    async def add(self, db: AsyncSession, product):
        try:
            db_item = Service(**product.dict())
            db.add(db_item)
            await db.commit()
            await db.refresh(db_item)
            return db_item
        except Exception as e:
            logger.error(f"{e}")

    async def update(self, db_read: AsyncSession,db_write:AsyncSession,service_id:UUID , name:str , description:str , price:str , shop_id:UUID ,duration:int, employee:int, owner:UUID) -> object:
        try:
            owner_id = (await
                    db_read.scalars(select(Shop.owner_id)
                    .join(Service, Shop.shop_uuid == Service.shop_uuid)
                    .filter(Service.service_uuid == service_id))).first()       
            service = (await db_read.scalars(select(Service).where(Service.service_uuid == service_id))).first()
            if owner_id is not None:
                if str(owner_id) == str(owner):
                    service.service_name = name
                    service.description = description
                    service.price = price
                    service.employees = employee
                    service.duration = duration
                    service = service.to_dict()
                    update_service_stament = (
                update(Service).where(Service.service_uuid == service_id).values(**service)
            ).execution_options(synchronize_session=False)
                    await db_write.execute(update_service_stament)
                    await db_write.commit()
                    return True
            return False
        except Exception as e:
            logger.error(f"{e}")
            return False
        

    async def delete(self,db_read:AsyncSession, db_write: AsyncSession, product_id, user_id):
        try:
            owner_id = (await
                    db_read.scalars(select(Shop.owner_id)
                    .join(Service, Shop.shop_uuid == Service.shop_uuid)
                    .filter(Service.service_uuid == product_id))).first()
            if owner_id is not None:
                if str(owner_id) == str(user_id):
                    service = (await db_read.scalars(select(Service).where(Service.service_uuid == product_id))).first()
                    await db_write.delete(service)
                    await db_write.commit()
                    return True
            return False
        except Exception as e:
            logger.error(f"{e}")

            
