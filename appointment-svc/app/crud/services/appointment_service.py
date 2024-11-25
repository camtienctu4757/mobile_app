from crud.repositories.appointment_repository import AppointmentRepository
from crud.irepositories.iappointment_repository import IAppointmentRepository
from uuid import UUID
from thirdparty.connections import PostgresConnection
import sys
from loguru import logger

sys.path.append('/')
sys.tracebacklimit = 0


class AppointmentService(IAppointmentRepository):
    def __init__(self,_appointment_repository: AppointmentRepository):
        self._appointment_repository =_appointment_repository

    async def get_id(self, db, booking_id: UUID,user_id: UUID) -> object:
        try:
            return await self._appointment_repository.get_id(db=db, booking_id=booking_id, user_id= user_id)
        except Exception as e:
            print(e)
            logger.error(f"{e}")

    async def get_all(self, db) -> list[object]:
        try:
            return await self._appointment_repository.get_all(db=db)
        except Exception as e:
            logger.error(f"{e}")
    async def get_success_user(self, db, user_id) -> list[object]:
        try:
            return await self._appointment_repository.get_success_user(db=db,user_id=user_id)
        
        except Exception as e:
            logger.error(f"{e}")
    async def get_booking_cancle(self, db, user_id) -> list[object]:
        try:
            return await self._appointment_repository.get_booking_cancle(db=db,user_id=user_id)
        
        except Exception as e:
            logger.error(f"{e}")
    
    async def get_booking_pending(self, db, user_id) -> list[object]:
        try:
            return await self._appointment_repository.get_booking_pending(db=db,user_id=user_id)
        
        except Exception as e:
            logger.error(f"{e}")


    async def get_byshop(self, db, shop_id,owner_id) -> list[object]:
        try:
            return await self._appointment_repository.get_byshop(db=db,shop_id= shop_id,owner_id=owner_id)
        except Exception as e:
            logger.error(f"{e}")
    async def get_bydate(self, db, booking_day) -> list[object]:
        try:
            return await self._appointment_repository.get_bydate(db=db,booking_day= booking_day)
        except Exception as e:
            logger.error(f"{e}")

    async def get_byshop_success(self, db, shop_id,owner_id) -> list[object]:
        try:
            return await self._appointment_repository.get_byshop_success(db=db,shop_id= shop_id,owner_id=owner_id)
        except Exception as e:
            logger.error(f"{e}")

    async def get_byshop_cancle(self, db, shop_id,owner_id) -> list[object]:
        try:
            return await self._appointment_repository.get_byshop_cancle(db=db,shop_id= shop_id,owner_id=owner_id)
        except Exception as e:
            logger.error(f"{e}")

    async def get_byshop_pending(self, db, shop_id,owner_id) -> list[object]:
        try:
            return await self._appointment_repository.get_byshop_pending(db=db,shop_id= shop_id,owner_id=owner_id)
        except Exception as e:
            logger.error(f"{e}")

    async def get_bydate(self, db, booking_day) -> list[object]:
        try:
            return await self._appointment_repository.get_bydate(db=db,booking_day= booking_day)
        except Exception as e:
            logger.error(f"{e}")
    
    async def get_booking_byuser(self, db, user_id) -> list[object]:
        try:
            return await self._appointment_repository.get_booking_byuser(db=db,user_id= user_id)
        except Exception as e:
            logger.error(f"{e}")
    
    async def create_booking(self,db, booking_infor):
        try:
            return await self._appointment_repository.create_booking(db =db,booking_infor=booking_infor
            )
        except Exception as e:
            logger.error(f"{e}")

    async def update_booking_success(self,db_write,db_read, appoint_id,owner_id):
        try:
            return await self._appointment_repository.update_booking_success(db_write=db_write,db_read=db_read,appoint_id=appoint_id,owner_id= owner_id
            )
        except Exception as e:
            logger.error(f"{e}")
    
    async def update_booking_cancle(self,db_write,db_read, appoint_id,user_id):
        try:
            return await self._appointment_repository.update_booking_cancle(db_write=db_write,db_read=db_read,appoint_id=appoint_id,user_id= user_id
            )
        except Exception as e:
            logger.error(f"{e}")


    async def get_timeslot_avalable(self, db, service_id)-> list[object]:
        try:
            return await self._appointment_repository.get_timeslot_avalable(db = db, service_id=service_id
            )
        except Exception as e:
            logger.error(f"{e}")

    async def get_timeslot_service(self, db, service_id)-> list[object]:
        try:
            return await self._appointment_repository.get_timeslot_service(db = db, service_id=service_id
            )
        except Exception as e:
            logger.error(f"{e}")

    async def get_timeslot_date(self, db, date)-> list[object]:
        try:
            return await self._appointment_repository.get_timeslot_date(db = db, date = date
            )
        except Exception as e:
            logger.error(f"{e}")

    async def get_timeslot_date_available(self, db, date)-> list[object]:
        try:
            return await self._appointment_repository.get_timeslot_date_available(db = db, date = date
            )
        except Exception as e:
            logger.error(f"{e}")

    async def add_product(self, db, product, style, file) -> object:
        try:
            return await self._appointment_repository.add_product(db, product, style, file)
        except Exception as e:
            logger.error(f"{e}")

    async def get_bycatalog(self, db, catalog_id) -> object:
        try:
            return await self._appointment_repository.get_bycatalog(db,catalog_id)
        except Exception as e:
            logger.error(f"{e}")

    async def get_byshop(self, db, shop_id,owner_id) -> object:
        try:
            return await self._appointment_repository.get_byshop(db,shop_id,owner_id)
        except Exception as e:
            logger.error(f"{e}")

    async def add(self, db, product) -> object:
        try:
            return await self._appointment_repository.add_product(db, product)
        except Exception as e:
            logger.error(f"{e}")

    async def update(self, db, product):
        try:
            return await self._appointment_repository.update(db,product=product)
        except Exception as e:
            logger.error(f"{e}")

    async def delete(self, db, product_id):
        try:
            return await self._appointment_repository.delete(db,product_id)
        except Exception as e:
            logger.error(f"{e}")

    async def run_async_job(self):
        db_read = await PostgresConnection.connect1(db_type="read")
        db_write = await PostgresConnection.connect1(db_type="write")
        return await self._appointment_repository.create_timeslots(db_read= db_read, db_write= db_write)
    
    async def run_async_job_everyday(self):
        db_read = await PostgresConnection.connect1(db_type="read")
        db_write = await PostgresConnection.connect1(db_type="write")
        return await self._appointment_repository.run_async_job_everyday(db_read= db_read, db_write= db_write)