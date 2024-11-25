from sqlalchemy.ext.declarative import DeclarativeMeta
from redis.asyncio.cluster import RedisCluster, ClusterNode
from confluent_kafka import Producer,Consumer,KafkaError,KafkaException
import thirdparty.connections as conn
from confluent_kafka import Producer,Consumer,KafkaError,KafkaException
from thirdparty.kafka.sessions import KafkaProducer,KafkaConsumer
from utils.constants.enum import Tags
from utils.constants.urls import Urls
from fastapi.encoders import jsonable_encoder
from sqlalchemy import text
import asyncio
import multiprocessing
import uuid
from fastapi import APIRouter, status, File, UploadFile, Form, Depends,  BackgroundTasks
from thirdparty.connections import RedisConnection
from thirdparty.kafka.executes import KafkaExcecute
from utils.constants.common.depends import Depend
from crud.services.product_service import ProductService
from crud.repositories.product_repository import ProductRepository
from schemas.requests.product_dto import Product as resquest_product
from schemas.respones.product_dto import Product as response_product
from typing import List
from thirdparty.minio.storage import FileStorage
from uuid import UUID
from fastapi.responses import StreamingResponse
import time
import json
from loguru import logger
from core.security import SecurityOauth2
from utils.constants.message import Message
from utils.helpers.helpers import Helper
from thirdparty.redis.caching import RedisCaching
from thirdparty.connections import PostgresConnection, RedisConnection, MinioConnection, KeycloakConnection, KafkaProducerConnection
from thirdparty.redis.sessions import RedisManager
import sys
sys.path.append('/')
router = APIRouter()

_product_service = ProductService(ProductRepository())


@router.get(Urls._get_all_product, response_model=List[response_product], tags=[Tags.Products.value])
async def get_product_all(db: Depend._async_read_db_dep):
    return await _product_service.get_all(db=db)


@router.get(Urls._get_product_id, tags=[Tags.Products.value], status_code=status.HTTP_200_OK)
@RedisCaching.api_caching(prefix="product", suffix=["product_id"], is_setcache=True, timeout=1000)
async def get_product_id(product_id: UUID, db: Depend._async_read_db_dep):
    try:
        data = await _product_service.get(product_id=product_id, db=db)
        if not data:
            return Helper.custom_error_json_response(status_code=status.HTTP_404_NOT_FOUND, message=Message._no_content)
        return Helper.custom_json_response(status_code=status.HTTP_200_OK, message=Message._success, data=jsonable_encoder(data))
    except Exception:
        return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message=Message._server_error)


@router.get("/test/redis_set_key", tags=[Tags.Products.value])
async def read_items():
    await RedisCaching.set_cache(key="token:camtien", value="token...",timeout=10)
    return "oklah"

@router.get("/test/redis-getc", tags=[Tags.Products.value])
async def read_items():
    await RedisCaching.get_cache(key="token:camtien")
    return "oklah"



@router.get("/test/redis_delete_cache", tags=[Tags.Products.value])
async def read_items():
    await RedisCaching.clear_cache(key="product65573c96-01b8-4097-9b8f-b586ad2ad3a0")
    return "ok"


@router.get("/test/redis_pattern_delete_cache", tags=[Tags.Products.value])
async def read_items():
    await RedisCaching.clear_pattern_cache(pattern="b*")
    return "ok"

@router.post("/test/upload_file", tags=[Tags.Products.value])
async def upload_file(file: UploadFile = File(...), filename: str = Form(...), folder_path: str = Form(...),):
    try:
        file_contents = await file.read()
        if await FileStorage.upload(file=file_contents, filename=filename, folder_path=folder_path):
            return Helper.custom_json_response(status_code=status.HTTP_200_OK, message=Message._success, data=Message._file_sucess)
        else:
            return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message=Message._file_error)
    except Exception:
        return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message=Message._server_error)


@router.get("/test/download_file", tags=[Tags.Products.value])
async def download_file(filename: str, folder_path: str):
    try:
        file = await FileStorage.download(filename=filename, folder_path=folder_path)
        if file:
            return StreamingResponse(file, media_type="application/octet-stream", headers={"Content-Disposition": f"attachment; filename={filename}"})
        else:
            return Helper.custom_error_json_response(status_code=status.HTTP_404_NOT_FOUND, message=Message._no_content)
    except Exception:
        return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message=Message._server_error)


@router.get("/test/auth", tags=[Tags.Products.value], dependencies=[Depends(SecurityOauth2(roles=["admin"]))])
async def auth():
    return "oklah"


@router.get("/test/noauth", tags=[Tags.Products.value])
async def auth():
    return "oklah1"

@router.get("/test/pro")
async def test1():
    await KafkaExcecute.produce(topic="test1", key=None, value=json.dumps({"test":"1"}))
    return "producer"

from utils.helpers.schedulers import Scheduler
from apscheduler.triggers.interval import IntervalTrigger

def test():
    logger.info("say hi")
@router.get("/schedule", tags=[Tags.Products.value])
async def auth():
    Scheduler().add_async_job(
    job=test,
    trigger=IntervalTrigger(seconds=3,))
    return "oklah1"

