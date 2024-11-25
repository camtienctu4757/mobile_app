
from thirdparty.connections import PostgresConnection, RedisConnection, MinioConnection, KeycloakConnection, KafkaProducerConnection, KafkaConsumerConnection
from contextlib import asynccontextmanager
from loguru import logger
from fastapi import BackgroundTasks
from thirdparty.kafka.executes import KafkaExcecute
import sys
from fastapi import FastAPI,BackgroundTasks
from pydantic import ValidationError
from fastapi.exceptions import RequestValidationError
from utils.constants.enum import ApiVersion
from routers.v1.endpoints import healthcheck, product
from utils.helpers.logger import LogConfig
from core.enviroment_params import get_env
from crud.services.product_service import ProductService
from crud.repositories.product_repository import ProductRepository
from sqlalchemy import text
import asyncio
import multiprocessing
import threading
sys.path.append('/')

_product_service = ProductService(ProductRepository())
async def test(msg,db):
    res = await _product_service.get_all(db=db)
    logger.info(f"msg {msg}")
    logger.info(f"res {res}")

def func():
    asyncio.run(KafkaExcecute.consume(test,['test1'],'test'))
    
    
    
from utils.helpers.schedulers import Scheduler
from apscheduler.triggers.interval import IntervalTrigger
from datetime import datetime, timedelta
def test():
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
    await MinioConnection.check_status()
    logger.info("Connecting the Minio successully!")
    # await KafkaProducerConnection.check_status()
    # logger.info("Producers connect to Kafka successully!")
    # KafkaConsumerConnection.check_status()
    # logger.info("Consumers connect to Kafka successully!")
    # consumer_task=multiprocessing.Process(target=KafkaExcecute.consume,args=(test,['tienlab'],'test',))
    # consumer_task=multiprocessing.Process(target=func)
    # consumer_task.start()
    
    await KeycloakConnection().check_status()
    logger.info("Connecting the Keycloak successully!")
    

    # Get from cache
    start_date = None
    # If has cache => start_date = cache
    # else (miss cache) 
    today = datetime.now()
    start_date = today.replace(hour=23, minute=0, second=0, microsecond=0)

    Scheduler().add_async_job(job=test,trigger=IntervalTrigger(seconds=259200,start_date=start_date))
    yield
    await RedisConnection.disconnect()
    logger.info("The postgres connection was closed!")
    await PostgresConnection.disconnect()
    logger.info("The redis connection was closed!")
    # consumer_task.join()


def get_application() -> FastAPI:
    application = FastAPI(
        title="Blah blah",
        summary="All is free!",
        version="1.0.0",
        contact={
            "name": "LTBao",
            "url": "http://ltbao.land/contact/",
            "email": "ltbao@gmail.com",
        },
        license_info={
            "name": "No license",
            "identifier": "None",
        },
        docs_url=get_env().DOC_URL if get_env().DOC_URL != "None" else None,
        redoc_url=get_env().REDOC_URL if get_env().REDOC_URL != "None" else None,
        lifespan=lifespan
    )

    application.add_exception_handler(
        ValidationError, LogConfig.custom_validation_exception_handler)

    application.add_exception_handler(RequestValidationError,
                                      LogConfig.custom_validation_exception_handler)

    application.include_router(healthcheck.router, prefix=ApiVersion.v1.value)
    application.include_router(product.router, prefix=ApiVersion.v1.value)

    # application.add_middleware(
    #     CORSMiddleware,
    #     allow_origins=['*'],
    #     allow_credentials=True,
    #     allow_methods=["*"],
    #     allow_headers=["*"],
    # )
    return application
