from crud.irepositories.iappointment_repository import IAppointmentRepository
from sqlalchemy import select, insert, func, update, and_
from sqlalchemy.ext.asyncio import AsyncSession
from thirdparty.db.models.services import Service
from thirdparty.db.models.users import User
from thirdparty.db.models.shops import Shop
from thirdparty.db.models.appointments import Appointment
from thirdparty.db.models.timeslot import TimeSlot
from thirdparty.db.models.employee_absence import EmployeeAbsences
from thirdparty.db.models.appointments import Status
from schemas.respones.appoint_dto import BookingOut
from datetime import datetime, timedelta, date
from thirdparty.redis.caching import RedisCaching
from uuid import UUID
from loguru import logger
import sys

sys.path.append("/")
sys.tracebacklimit = 0


class AppointmentRepository(IAppointmentRepository):
    async def get_id(self, db: AsyncSession, booking_id: UUID, user_id: UUID) -> object:
        try:
            # shop = (await db_read.scalars(select(Shop).where(Shop.owner_id == user_id))).first()
            # user = (await db_read.scalars(select(User).where(User.user_uuid == user_id))).first()
            # if (shop or user):
            result = (
                await db.execute(
                    select(
                        Service.price,
                        Service.duration,
                        Shop.shop_name,
                        Shop.address,
                        TimeSlot.slot_date,
                        TimeSlot.start_time,
                        Appointment.appointment_uuid,
                        Service.service_name,
                    )
                    .join(TimeSlot, Appointment.timeslot_uuid == TimeSlot.slot_uuid)
                    .join(Service, TimeSlot.service_uuid == Service.service_uuid)
                    .join(Shop, Service.shop_uuid == Shop.shop_uuid)
                    .where(Appointment.appointment_uuid == booking_id)
                )
            ).all()
            final = []
            for appointment in result:
                final.append(BookingOut.model_validate(appointment))
            return final
        except Exception as e:
            print(e)
            logger.error(f"{e}")

    async def get_all(self, db: AsyncSession) -> list[object]:
        try:
            return (await db.scalars(select(Appointment))).all()
        except Exception as e:
            logger.error(f"{e}")

    async def create_booking(self, db: AsyncSession, booking_infor) -> object:
        try:
            new_booking = Appointment(
                user_uuid=booking_infor.user_uuid,
                timeslot_uuid=booking_infor.timeslot_uuid,
            )
            db.add(new_booking)
            await db.commit()
            await db.refresh(new_booking)
            stmt = (
                update(TimeSlot)
                .where(TimeSlot.slot_uuid == new_booking.timeslot_uuid)
                .values(
                    available_employees=(
                        select(TimeSlot.available_employees)
                        .where(TimeSlot.slot_uuid == new_booking.timeslot_uuid)
                        .scalar_subquery()
                        - 1
                    ),
                    updated_at=datetime.now(),
                )
            )
            await db.execute(stmt)
            await db.commit()
            return new_booking
        except Exception as e:
            logger.error(f"{e}")

    async def get_timeslot_avalable(self, db: AsyncSession, service_id) -> list[object]:
        try:
            return (
                await db.scalars(
                    select(TimeSlot).where(
                        TimeSlot.service_uuid == service_id
                        and TimeSlot.available_employees > 0
                    )
                )
            ).all()
        except Exception as e:
            logger.error(f"{e}")

    async def get_timeslot_service(self, db: AsyncSession, service_id) -> list[object]:
        try:
            today = datetime.now().date()
            day_after_tomorrow = today + timedelta(days=2)
            conditions = and_(
                TimeSlot.service_uuid == service_id,
                TimeSlot.slot_date >= today,
                TimeSlot.slot_date <= day_after_tomorrow,
            )
            return (await db.scalars(select(TimeSlot).where(conditions))).all()
        except Exception as e:
            logger.error(f"{e}")

    async def get_timeslot_date(self, db: AsyncSession, date) -> list[object]:
        try:
            return (
                await db.scalars(select(TimeSlot).where(TimeSlot.slot_date == date))
            ).all()
        except Exception as e:
            logger.error(f"{e}")

    async def get_timeslot_date_available(self, db: AsyncSession, date) -> list[object]:
        try:
            return (
                await db.scalars(
                    select(TimeSlot).where(
                        TimeSlot.slot_date == date, TimeSlot.available_employees > 0
                    )
                )
            ).all()
        except Exception as e:
            logger.error(f"{e}")

    async def get_byshop(
        self, db: AsyncSession, shop_id: UUID, owner_id: UUID
    ) -> list[object]:
        try:
            owner = (
                await db.scalars(select(Shop).where(Shop.owner_id == owner_id))
            ).first()
            if owner is not None:
                return (
                    await db.scalars(
                        select(Appointment)
                        .join(TimeSlot, Appointment.timeslot_uuid == TimeSlot.slot_uuid)
                        .join(Service, TimeSlot.service_uuid == Service.service_uuid)
                        .join(Shop, Service.shop_uuid == Shop.shop_uuid)
                        .where(Shop.shop_uuid == shop_id)
                    )
                ).all()
            return []
        except Exception as e:
            logger.error(f"{e}")

    async def get_byshop_success(
        self, db: AsyncSession, shop_id: UUID, owner_id: UUID
    ) -> list[object]:
        try:
            owner = (
                await db.scalars(select(Shop).where(Shop.owner_id == owner_id))
            ).first()
            if owner is not None:
                status = (
                    await db.scalars(
                        select(Status.id_status).where(Status.status_name == "success")
                    )
                ).first()
                return (
                    await db.scalars(
                        select(Appointment)
                        .join(TimeSlot, Appointment.timeslot_uuid == TimeSlot.slot_uuid)
                        .join(Service, TimeSlot.service_uuid == Service.service_uuid)
                        .join(Shop, Service.shop_uuid == Shop.shop_uuid)
                        .where(Shop.shop_uuid == shop_id, Appointment.status == status)
                    )
                ).all()
            return []
        except Exception as e:
            logger.error(f"{e}")

    async def get_byshop_cancle(
        self, db: AsyncSession, shop_id: UUID, owner_id: UUID
    ) -> list[object]:
        try:
            owner = (
                await db.scalars(select(Shop).where(Shop.owner_id == owner_id))
            ).first()
            if owner is not None:
                status = (
                    await db.scalars(
                        select(Status.id_status).where(Status.status_name == "cancle")
                    )
                ).first()
                return (
                    await db.scalars(
                        select(Appointment)
                        .join(TimeSlot, Appointment.timeslot_uuid == TimeSlot.slot_uuid)
                        .join(Service, TimeSlot.service_uuid == Service.service_uuid)
                        .join(Shop, Service.shop_uuid == Shop.shop_uuid)
                        .where(Shop.shop_uuid == shop_id, Appointment.status == status)
                    )
                ).all()
            return []
        except Exception as e:
            logger.error(f"{e}")

    async def get_byshop_pending(
        self, db: AsyncSession, shop_id: UUID, owner_id: UUID
    ) -> list[object]:
        try:
            owner = (
                await db.scalars(select(Shop).where(Shop.owner_id == owner_id))
            ).first()
            if owner is not None:
                status = (
                    await db.scalars(
                        select(Status.id_status).where(Status.status_name == "pending")
                    )
                ).first()
                return (
                    await db.scalars(
                        select(Appointment)
                        .join(TimeSlot, Appointment.timeslot_uuid == TimeSlot.slot_uuid)
                        .join(Service, TimeSlot.service_uuid == Service.service_uuid)
                        .join(Shop, Service.shop_uuid == Shop.shop_uuid)
                        .where(Shop.shop_uuid == shop_id, Appointment.status == status)
                    )
                ).all()
            return []
        except Exception as e:
            logger.error(f"{e}")

    async def get_success_user(self, db: AsyncSession, user_id: UUID) -> list[object]:
        try:
            status = (
                await db.scalars(
                    select(Status.id_status).where(Status.status_name == "success")
                )
            ).first()
            result = (
                await db.execute(
                    select(
                        Service.price,
                        Service.duration,
                        Shop.shop_name,
                        Shop.address,
                        TimeSlot.slot_date,
                        TimeSlot.start_time,
                        Appointment.appointment_uuid,
                        Service.service_name,
                    )
                    .join(TimeSlot, Appointment.timeslot_uuid == TimeSlot.slot_uuid)
                    .join(Service, TimeSlot.service_uuid == Service.service_uuid)
                    .join(Shop, Service.shop_uuid == Shop.shop_uuid)
                    .where(
                        Appointment.user_uuid == user_id, Appointment.status == status
                    )
                )
            ).all()
            final = []
            for appointment in result:
                final.append(BookingOut.model_validate(appointment))
            return final
        except Exception as e:
            logger.error(f"{e}")

    async def get_booking_cancle(self, db: AsyncSession, user_id: UUID) -> list[object]:
        try:
            status = (
                await db.scalars(
                    select(Status.id_status).where(Status.status_name == "cancle")
                )
            ).first()
            result = (
                await db.execute(
                    select(
                        Service.price,
                        Service.duration,
                        Shop.shop_name,
                        Shop.address,
                        TimeSlot.slot_date,
                        TimeSlot.start_time,
                        Appointment.appointment_uuid,
                        Service.service_name,
                    )
                    .join(TimeSlot, Appointment.timeslot_uuid == TimeSlot.slot_uuid)
                    .join(Service, TimeSlot.service_uuid == Service.service_uuid)
                    .join(Shop, Service.shop_uuid == Shop.shop_uuid)
                    .where(
                        Appointment.user_uuid == user_id, Appointment.status == status
                    )
                )
            ).all()
            final = []
            for appointment in result:
                final.append(BookingOut.model_validate(appointment))
            return final
        except Exception as e:
            logger.error(f"{e}")

    async def get_booking_pending(
        self, db: AsyncSession, user_id: UUID
    ) -> list[object]:
        try:
            status = (
                await db.scalars(
                    select(Status.id_status).where(Status.status_name == "pending")
                )
            ).first()
            result = (
                await db.execute(
                    select(
                        Service.price,
                        Service.duration,
                        Shop.shop_name,
                        Shop.address,
                        TimeSlot.slot_date,
                        TimeSlot.start_time,
                        Appointment.appointment_uuid,
                        Service.service_name,
                    )
                    .join(TimeSlot, Appointment.timeslot_uuid == TimeSlot.slot_uuid)
                    .join(Service, TimeSlot.service_uuid == Service.service_uuid)
                    .join(Shop, Service.shop_uuid == Shop.shop_uuid)
                    .where(
                        Appointment.user_uuid == user_id, Appointment.status == status
                    )
                )
            ).all()
            final = []
            for appointment in result:
                final.append(BookingOut.model_validate(appointment))
            return final
        except Exception as e:
            logger.error(f"{e}")

    async def get_booking_byuser(self, db: AsyncSession, user_id: UUID) -> list[object]:
        try:
            appoint_list = (
                await db.execute(
                    select(
                        Service.price,
                        Service.duration,
                        Shop.shop_name,
                        Shop.address,
                        TimeSlot.slot_date,
                        TimeSlot.start_time,
                        Appointment.appointment_uuid,
                        Service.service_name,
                    )
                    .join(TimeSlot, Appointment.timeslot_uuid == TimeSlot.slot_uuid)
                    .join(Service, TimeSlot.service_uuid == Service.service_uuid)
                    .join(Shop, Service.shop_uuid == Shop.shop_uuid)
                    .where(Appointment.user_uuid == user_id)
                )
            ).all()
            data = []
            for item in appoint_list:
                data.append(BookingOut.model_validate(item))
            return data
        except Exception as e:
            print(e)
            logger.error(f"{e}")

    async def get_bydate(self, db: AsyncSession, booking_day: date) -> list[object]:
        try:
            appoint_list = (
                await db.execute(
                    select(
                        Service.price,
                        Service.duration,
                        Shop.shop_name,
                        Shop.address,
                        TimeSlot.slot_date,
                        TimeSlot.start_time,
                        Appointment.appointment_uuid,
                        Service.service_name,
                    )
                    .join(TimeSlot, Appointment.timeslot_uuid == TimeSlot.slot_uuid)
                    .join(Service, TimeSlot.service_uuid == Service.service_uuid)
                    .join(Shop, Service.shop_uuid == Shop.shop_uuid)
                    .where(TimeSlot.slot_date == booking_day)
                )
            ).all()
            data = []
            for item in appoint_list:
                data.append(BookingOut.model_validate(item))
            return data
        except Exception as e:
            print(e)
            logger.error(f"{e}")

    # cheking
    async def update_booking_success(
        self,
        db_write: AsyncSession,
        db_read: AsyncSession,
        appoint_id: UUID,
        owner_id: UUID,
    ) -> object:
        try:
            shop = (
                await db_read.scalars(select(Shop).where(Shop.owner_id == owner_id))
            ).first()
            if shop is None:
                return False
            await db_write.execute(
                update(Appointment)
                .where(Appointment.appointment_uuid == appoint_id)
                .values(
                    status=await db_read.scalar(
                        select(Status.id_status).where(
                            Status.status_name == "success",
                        )
                    ),
                    updated_at=datetime.now(),
                )
            )
            await db_write.commit()
            return True
        except Exception as e:
            logger.error(f"{e}")
            return False

    async def update_booking_cancle(
        self,
        db_write: AsyncSession,
        db_read: AsyncSession,
        appoint_id: UUID,
        user_id: UUID,
    ) -> object:
        try:
            shop = (
                await db_read.scalars(select(Shop).where(Shop.owner_id == user_id))
            ).first()
            user = (
                await db_read.scalars(select(User).where(User.user_uuid == user_id))
            ).first()
            if shop or user:
                await db_write.execute(
                    update(Appointment)
                    .where(Appointment.appointment_uuid == appoint_id)
                    .values(
                        status=await db_read.scalar(
                            select(Status.id_status).where(
                                Status.status_name == "cancle",
                            )
                        ),
                        updated_at=datetime.now(),
                    )
                )
                await db_write.commit()
            return True
        except Exception as e:
            logger.error(f"{e}")
            return False

    async def count_absent_staff(self,db_read:AsyncSession, service_uuid, current_date, start_time):
        count_absent = (
                await db_read.scalars(select(func.count()).where(and_(EmployeeAbsences.service_uuid == service_uuid, EmployeeAbsences.absence_date == current_date, EmployeeAbsences.start_time == start_time)))
            ).first()
        return count_absent
   

    async def create_timeslots(self, db_read: AsyncSession, db_write: AsyncSession):
        try:
            logger.info("Creating_timeslots")
            logger.info("cron job starting...")
            services_list = (
                await db_read.scalars(select(Service).where(Service.is_enable != False))
            ).all()
            timeslot_records = []
            for service in services_list:
                shop = (
                    await db_read.scalars(
                        select(Shop).where(Shop.shop_uuid == service.shop_uuid)
                    )
                ).first()
                open_time = shop.open_time
                close_time = shop.close_time
                duration = service.duration
                # slot_date = datetime.now() + timedelta(days=1)
                slot_date = datetime.now()
                for day in range(3):
                    current_date = slot_date + timedelta(days=day)
                    start_time = datetime.combine(current_date, open_time)
                    end_time = datetime.combine(current_date, close_time)
                    while start_time + timedelta(minutes=duration) <= end_time:
                        absent_employees = await self.count_absent_staff(
                            db_read, service.service_uuid, current_date, start_time
                        )
                        available_employees = max(
                            0, service.employees - absent_employees
                        )
                        if available_employees > 0:
                            timeslot_records.append(
                                {
                                    "service_uuid": service.service_uuid,
                                    "start_time": start_time,
                                    "end_time": start_time
                                    + timedelta(minutes=duration),
                                    "available_employees": available_employees,
                                    "slot_date": current_date,
                                }
                            )
                        start_time += timedelta(minutes=duration)
            if timeslot_records:
                stmt = insert(TimeSlot).values(timeslot_records)
                await db_write.execute(stmt)
                await db_write.commit()
                start_date = datetime.now()
                await RedisCaching.set_cache(
                    key="start_date_job", value=f"{start_date.replace(hour=23, minute=00, second=00, microsecond=00)}"
                )
            logger.info("cron job completed")
        except Exception as e:
            logger.exception(e)


    async def run_async_job_everyday(self, db_read: AsyncSession, db_write: AsyncSession):
        try:
            logger.info("cron job starting...")
            services_list = (
                await db_read.scalars(select(Service).where(Service.is_enable != False))
            ).all()
            timeslot_records = []
            for service in services_list:
                shop = (
                    await db_read.scalars(
                        select(Shop).where(Shop.shop_uuid == service.shop_uuid)
                    )
                ).first()
                open_time = shop.open_time
                close_time = shop.close_time
                duration = service.duration
                slot_date = datetime.now() + timedelta(days=2)
                start_time = datetime.combine(slot_date, open_time)
                end_time = datetime.combine(slot_date, close_time)
                while start_time + timedelta(minutes=duration) <= end_time:
                    absent_employees = await self.count_absent_staff(
                        db_read, service.service_uuid, slot_date, start_time
                    )
                    available_employees = max(0, service.employees - absent_employees)
                    if available_employees > 0:
                        timeslot_records.append(
                            {
                                "service_uuid": service.service_uuid,
                                "start_time": start_time,
                                "end_time": start_time + timedelta(minutes=duration),
                                "available_employees": available_employees,
                                "slot_date": slot_date,
                            }
                        )
                    start_time += timedelta(minutes=duration)
            if timeslot_records:
                stmt = insert(TimeSlot).values(timeslot_records)
                await db_write.execute(stmt)
                await db_write.commit()
                start_date = datetime.now().replace(hour=23, minute=0, second=0)
                await RedisCaching.set_cache(key="start_date_job", value=f"{start_date}")
            logger.info("cron job completed")
        except Exception as e:
            logger.exception(e)


    
#  crud.repositories.appointment_repository:create_timeslots:406 - unsupported operand type(s) for -: 'NoneType' and 'int'
# TypeError: unsupported operand type(s) for -: 'NoneType' and 'int'
