from thirdparty.connections import (
    PostgresConnection,
    RedisConnection,
    MinioConnection,
    KeycloakConnection,
)
from contextlib import asynccontextmanager
from loguru import logger
from fastapi import FastAPI
from pydantic import ValidationError
from fastapi.exceptions import RequestValidationError
from utils.constants.enum import ApiVersion
from routers.v1.endpoints import healthcheck, appointment
from utils.helpers.logger import LogConfig
from core.enviroment_params import get_env
from apscheduler.schedulers.background import BackgroundScheduler
from apscheduler.triggers.interval import IntervalTrigger
from crud.repositories.appointment_repository import AppointmentRepository
from crud.services.appointment_service import AppointmentService
from datetime import datetime
from utils.helpers.schedulers import Scheduler
from thirdparty.redis.caching import RedisCaching
from datetime import datetime, timedelta
from apscheduler.triggers.date import DateTrigger
# from routers.v1.endpoints.appointment import run_async_job

# sys.path.append('/')
# scheduler = BackgroundScheduler()
# scheduler.add_job(run_async_job, trigger=IntervalTrigger(minutes=2))
# scheduler.start()
_appoiment_service = AppointmentService(AppointmentRepository())
async def test():
    start_date = datetime.now()
    await RedisCaching.set_cache(key='start_date_job',value=f'{start_date}')
    logger.info("say hi")

@asynccontextmanager
async def lifespan(app: FastAPI):
    LogConfig.config()
    logger.info("Configuring log successully!")
    await PostgresConnection.check_status()
    logger.info("Connecting the Postgres database successully!")
    await RedisConnection.check_status()
    await RedisConnection.set_job_delete_idle_connection()
    logger.info("Connecting the Redis successully!")
    # await set_job_create_time_slot()
    # await MinioConnection.check_status()
    # logger.info("Connecting the Minio successully!")
    # await KeycloakConnection().check_status()
    # logger.info("Connecting the Keycloak successully!")

    # Get from cache
    start_date = await RedisCaching.get_cache(key="start_date_job")
    logger.debug(f"start_date: {start_date}")
    if start_date is None:
        today = datetime.now()
        start_date = today.replace(hour=23, minute=00, second=0, microsecond=0)
        Scheduler().add_async_job(
        job=_appoiment_service.run_async_job, 
        trigger=DateTrigger(run_date=start_date))
    Scheduler().add_async_job(job=_appoiment_service.run_async_job_everyday,trigger=IntervalTrigger(seconds=864000, start_date = datetime.fromisoformat(str(start_date))))
    yield
    await RedisConnection.disconnect()
    logger.info("The postgres connection was closed!")
    await PostgresConnection.disconnect()
    logger.info("The redis connection was closed!")


def get_application() -> FastAPI:
    application = FastAPI(
        title="Blah blah",
        summary="All is free!",
        version="1.0.0",
        license_info={
            "name": "No license",
            "identifier": "None",
        },
        docs_url=get_env().DOC_URL if get_env().DOC_URL != "None" else None,
        redoc_url=get_env().REDOC_URL if get_env().REDOC_URL != "None" else None,
        lifespan=lifespan,
    )

    application.add_exception_handler(
        ValidationError, LogConfig.custom_validation_exception_handler
    )

    application.add_exception_handler(
        RequestValidationError, LogConfig.custom_validation_exception_handler
    )

    application.include_router(healthcheck.router, prefix=ApiVersion.v1.value)
    application.include_router(appointment.router, prefix=ApiVersion.v1.value)

    # application.add_middleware(
    #     CORSMiddleware,
    #     allow_origins=['*'],
    #     allow_credentials=True,
    #     allow_methods=["*"],
    #     allow_headers=["*"],
    # )
    return application
