from utils.constants.enum import Tags
from utils.constants.urls import Urls
from fastapi.encoders import jsonable_encoder
from fastapi import APIRouter, status,BackgroundTasks,Depends
from utils.constants.common.depends import Depend
from core.security import SecurityOauth2
from uuid import UUID
import uuid
from apscheduler.triggers.interval import IntervalTrigger
from loguru import logger
from utils.constants.message import Message
from utils.helpers.helpers import Helper
from thirdparty.redis.caching import RedisCaching
from crud.services.appointment_service import AppointmentService
from crud.repositories.appointment_repository import AppointmentRepository
from schemas.requests.appoint_dto import Booking
from datetime import date
import thirdparty.connections as conn
import multiprocessing
import sys
from utils.helpers.schedulers import Scheduler
import asyncio
sys.path.append('/')
router = APIRouter()
_appointment_service = AppointmentService(AppointmentRepository())


@router.get(Urls._get_booking_success, tags=[Tags.Bookings.value])
async def get_success_bookings(db: Depend._async_read_db_dep, user_infor: dict = Depends(SecurityOauth2(roles=["public"]))):
    try:
        result = await _appointment_service.get_success_user(db=db, user_id=uuid.UUID(str(user_infor['sub']).split(':')[-1]))
        if not result:
            return Helper.custom_error_json_response(status_code=status.HTTP_404_NOT_FOUND, message_error=Message._no_content)
        return Helper.custom_json_response(status_code=status.HTTP_200_OK, data=jsonable_encoder(result), message=Message._success)
    except Exception:
        return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message_error=Message._server_error)

@router.get(Urls._get_booking_cancle, tags=[Tags.Bookings.value])
async def get_booking_cancle(db: Depend._async_read_db_dep, user_infor: dict = Depends(SecurityOauth2(roles=["public"]))):
    try:
        result = await _appointment_service.get_booking_cancle(db=db, user_id=uuid.UUID(str(user_infor['sub']).split(':')[-1]))
        if not result:
            return Helper.custom_error_json_response(status_code=status.HTTP_404_NOT_FOUND, message_error=Message._no_content)
        return Helper.custom_json_response(status_code=status.HTTP_200_OK, data=jsonable_encoder(result), message=Message._success)
    except Exception as e:
        logger.error(e)
        return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message_error=Message._server_error)


@router.get(Urls._get_booking_pendings, tags=[Tags.Bookings.value])
async def get_booking_pending(db: Depend._async_read_db_dep,user_infor: dict = Depends(SecurityOauth2(roles=["public"]))):
    try:
        result = await _appointment_service.get_booking_pending(db=db, user_id=uuid.UUID(str(user_infor['sub']).split(':')[-1]))
        if not result:
            return Helper.custom_error_json_response(status_code=status.HTTP_404_NOT_FOUND, message_error=Message._no_content)
        return Helper.custom_json_response(status_code=status.HTTP_200_OK, data=jsonable_encoder(result), message=Message._success)
    except Exception as e:
        logger.error(e)
        return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message_error=Message._server_error)
    

@router.get(Urls._get_booking_byshop_success, tags=[Tags.Bookings.value])
async def get_booking_shop_success(db: Depend._async_read_db_dep,shop_id:UUID,user_infor: dict = Depends(SecurityOauth2(roles=["shop"]))):
    try:
        result = await _appointment_service.get_byshop_success(db=db, shop_id=shop_id, owner_id = uuid.UUID(str(user_infor['sub']).split(':')[-1]) )
        if not result:
            return Helper.custom_error_json_response(status_code=status.HTTP_404_NOT_FOUND, message_error=Message._no_content)
        return Helper.custom_json_response(status_code=status.HTTP_200_OK, data=jsonable_encoder(result), message=Message._success)
    except Exception as e:
        logger.exception(e)
        return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message_error=Message._server_error)

@router.get(Urls._get_booking_byshop_cancle, tags=[Tags.Bookings.value])
async def get_booking_shop_cancle(db: Depend._async_read_db_dep,shop_id:UUID,user_infor: dict = Depends(SecurityOauth2(roles=["shop"]))):
    try:
        result = await _appointment_service.get_byshop_cancle(db=db, shop_id=shop_id, owner_id = uuid.UUID(str(user_infor['sub']).split(':')[-1]) )
        if not result:
            return Helper.custom_error_json_response(status_code=status.HTTP_404_NOT_FOUND, message_error=Message._no_content)
        return Helper.custom_json_response(status_code=status.HTTP_200_OK, data=jsonable_encoder(result), message=Message._success)
    except Exception as e:
        logger.exception(e)
        return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message_error=Message._server_error)

@router.get(Urls._get_booking_byshop_pending, tags=[Tags.Bookings.value])
async def get_booking_shop_pending(db: Depend._async_read_db_dep,shop_id:UUID,user_infor: dict = Depends(SecurityOauth2(roles=["shop"]))):
    try:
        result = await _appointment_service.get_byshop_pending(db=db, shop_id=shop_id, owner_id = uuid.UUID(str(user_infor['sub']).split(':')[-1]) )
        if not result:
            return Helper.custom_error_json_response(status_code=status.HTTP_404_NOT_FOUND, message_error=Message._no_content)
        return Helper.custom_json_response(status_code=status.HTTP_200_OK, data=jsonable_encoder(result), message=Message._success)
    except Exception as e:
        logger.exception(e)
        return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message_error=Message._server_error)


@router.get(Urls._get_booking_byshop, tags=[Tags.Bookings.value])
async def get_booking_shop(db: Depend._async_read_db_dep,shop_id:UUID,user_infor: dict = Depends(SecurityOauth2(roles=["shop"]))):
    try:
        result = await _appointment_service.get_byshop(db=db, shop_id=shop_id, owner_id = uuid.UUID(str(user_infor['sub']).split(':')[-1]) )
        if not result:
            return Helper.custom_error_json_response(status_code=status.HTTP_404_NOT_FOUND, message_error=Message._no_content)
        return Helper.custom_json_response(status_code=status.HTTP_200_OK, data=jsonable_encoder(result), message=Message._success)
    except Exception as e:
        logger.exception(e)
        return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message_error=Message._server_error)


@router.get(Urls._get_booking_byday, tags=[Tags.Bookings.value])
async def get_booking_bydate(db: Depend._async_read_db_dep,booking_day:date):
    try:
        result = await _appointment_service.get_bydate(db=db, booking_day=booking_day)
        if not result:
            return Helper.custom_error_json_response(status_code=status.HTTP_404_NOT_FOUND, message=Message._no_content)
        return Helper.custom_json_response(status_code=status.HTTP_200_OK, data=jsonable_encoder(result), message=Message._success)
    except Exception as e:
        print (e)
        return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message_error=Message._server_error)


@router.get(Urls._get_booking_byuser, tags=[Tags.Bookings.value])
async def get_booking_byuser(db: Depend._async_read_db_dep,user_infor: dict = Depends(SecurityOauth2(roles=["public"]))):
    try:
        result = await _appointment_service.get_booking_byuser(db=db,user_id=uuid.UUID(str(user_infor['sub']).split(':')[-1]) )
        if result is not None:
            return Helper.custom_json_response(status_code=status.HTTP_200_OK, data=jsonable_encoder(result), message=Message._success)
        return Helper.custom_json_response(data="", message=Message._not_found, status_code=status.HTTP_404_NOT_FOUND)
    except Exception as e:
        logger.error(e)
        return Helper.custom_error_json_response(status_code=status.
        HTTP_500_INTERNAL_SERVER_ERROR, message_error=Message._server_error)
    
@router.patch(Urls._update_booking_success, tags=[Tags.Bookings.value])
async def update_booking_success(db_write:Depend._async_write_db_dep,db_read:Depend._async_read_db_dep,appoint_id:UUID,user_infor: dict = Depends(SecurityOauth2(roles=["shop"]))):
    try:
        result = await _appointment_service.update_booking_success(db_write=db_write,db_read=db_read,appoint_id=appoint_id,owner_id = uuid.UUID(str(user_infor['sub']).split(':')[-1]))
        if result == False:
            return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message_error=Message._server_error)
        return Helper.custom_json_response(status_code=status.HTTP_200_OK, data='', message=Message._success)
    except Exception as e:
        logger.error(e)
        return Helper.custom_error_json_response(status_code=status.
        HTTP_500_INTERNAL_SERVER_ERROR, message_error=Message._server_error)

@router.patch(Urls._update_booking_cancle, tags=[Tags.Bookings.value])
async def update_booking_cancle(db_write:Depend._async_write_db_dep,db_read:Depend._async_read_db_dep,appoint_id:UUID,user_infor: dict = Depends(SecurityOauth2(roles=["shop","public"]))):
    try:
        result = await _appointment_service.update_booking_cancle(db_write=db_write,db_read=db_read,appoint_id=appoint_id,user_id = uuid.UUID(str(user_infor['sub']).split(':')[-1]))
        if result == False:
            return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message_error=Message._server_error)
        return Helper.custom_json_response(status_code=status.HTTP_200_OK, data='', message=Message._success)
    except Exception as e:
        logger.error(e)
        return Helper.custom_error_json_response(status_code=status.
        HTTP_500_INTERNAL_SERVER_ERROR, message_error=Message._server_error)
    
@router.get(Urls._get_booking_byid,response_model= Helper.custom_json_response, tags=[Tags.Bookings.value])
@RedisCaching.api_caching(prefix="appointment", suffix=["booking_id"], is_setcache=True, timeout=1000)
async def get_booking_byid(db: Depend._async_read_db_dep, booking_id: UUID,user_infor: dict = Depends(SecurityOauth2(roles=["public","shop"]))):
    try:
        result = await _appointment_service.get_id(db=db, booking_id = booking_id,user_id = uuid.UUID(str(user_infor['sub']).split(':')[-1]))
        if not result:
            return Helper.custom_error_json_response(status_code=status.HTTP_404_NOT_FOUND, message_error=Message._no_content)
        return Helper.custom_json_response(status_code=status.HTTP_200_OK, data=jsonable_encoder(result), message=Message._success)
    except Exception as e:
        print(e)
        return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message_error=Message._server_error)

@router.get(Urls._get_all_bookings, tags=[Tags.Bookings.value],dependencies=[Depends(SecurityOauth2(roles=["admin"]))])
async def get_all(db: Depend._async_read_db_dep):
    try:
        result = await _appointment_service.get_all(db=db)
        return Helper.custom_json_response(status_code=status.HTTP_200_OK, data=jsonable_encoder(result), message=Message._success)
    except Exception:
        return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message_error=Message._server_error)

@router.post(Urls._create_booking, tags=[Tags.Bookings.value],dependencies=[Depends(SecurityOauth2(roles=["public"]))])
async def create_booking(db: Depend._async_write_db_dep, booking_infor:Booking):
    try:
        result = await _appointment_service.create_booking(db=db, booking_infor=booking_infor)
        
        return Helper.custom_json_response(status_code=status.HTTP_201_CREATED,data=jsonable_encoder(result), message=Message._success)
    except Exception as e:
        print(e)
        return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message_error=Message._server_error)
    
@router.get(Urls._get_timeslot_bydate_available, tags=[Tags.Bookings.value])
async def get_timeslot_bydate_available(db:Depend._async_read_db_dep,date: date):
    try:
        result = await _appointment_service.get_timeslot_date_available(db=db, date =date)
        if not result:
            return Helper.custom_error_json_response(status_code=status.HTTP_404_NOT_FOUND, message_error=Message._no_content)
        return Helper.custom_json_response(status_code=status.HTTP_200_OK,data=jsonable_encoder(result), message=Message._success)
    except Exception:
        return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message_error=Message._server_error)

@router.get(Urls._get_timeslot_bydate, tags=[Tags.Bookings.value])
async def get_timeslot_date(db:Depend._async_read_db_dep,date: date):
    try:
        result = await _appointment_service.get_timeslot_date(db=db,date =date)
        return Helper.custom_json_response(status_code=status.HTTP_200_OK,data=jsonable_encoder(result), message=Message._success)
    except Exception:
        return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message_error=Message._server_error)

@router.get(Urls._get_timeslot_service_all, tags=[Tags.Bookings.value])
async def get_timeslot_service(db:Depend._async_read_db_dep,service_id: UUID):
    try:
        result = await _appointment_service.get_timeslot_service(db=db, service_id=service_id)
        if not result:
            return Helper.custom_error_json_response(status_code=status.HTTP_404_NOT_FOUND, message_error=Message._no_content)
        return Helper.custom_json_response(status_code=status.HTTP_200_OK,data=jsonable_encoder(result), message=Message._success)
    except Exception:
        return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message_error=Message._server_error)

@router.get(Urls._get_timeslot_byservice_available, tags=[Tags.Bookings.value])
async def get_timeslot_available(db:Depend._async_read_db_dep,service_id: UUID):
    try:
        result = await _appointment_service.get_timeslot_avalable(db=db, service_id=service_id)
        return Helper.custom_json_response(status_code=status.HTTP_200_OK,data=jsonable_encoder(result), message=Message._success)
    except Exception:
        return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message_error=Message._server_error)

@router.get("/test/redis_delete_cache", tags=[Tags.Bookings.value])
async def read_items():
    await RedisCaching.clear_cache(key="appointment0bf23d51-2ae2-4e6d-aea9-dd3fd6902b1b")
    return "ok"

# test create time_slots
# @router.get(Urls._create_timeslot, tags=[Tags.Bookings.value])
# async def run_async_job(db_read: Depend._async_read_db_dep,db_write: Depend._async_write_db_dep):
#     await _appointment_service.run_async_job(db_read=db_read,db_write=db_write)

# @router.get("/schedule", tags=[Tags.Products.value])
# async def auth():
#     Scheduler().add_async_job(
#     job=test,
#     trigger=IntervalTrigger(seconds=3,))
#     return "oklah1"


@router.get("/test/redis_pattern_delete_cache")
async def read_items():
    await RedisCaching.clear_cache(key='start_date_job')
    return "ok"