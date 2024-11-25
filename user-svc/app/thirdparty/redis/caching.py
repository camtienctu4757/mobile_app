import json
import sys
import time
from functools import wraps
from loguru import logger
from typing import Callable
from core.enviroment_params import get_env
import thirdparty.connections as conn
from fastapi import status
from fastapi.responses import JSONResponse
from fastapi.encoders import jsonable_encoder
import redis.asyncio as redis
from utils.helpers.helpers import Helper
from utils.constants.message import Message
sys.path.append('/')
sys.tracebacklimit = 0


class RedisCaching():
    __redis_namespace: str = get_env().REDIS_NAMESPACE

    @classmethod
    def api_caching(self, prefix="", suffix=[], is_setcache=False, timeout=60) -> JSONResponse:
        def decorator(func: Callable):
            @wraps(func)
            async def wrapper(*args, **kwargs):
                try:
                    key = self.__redis_namespace + prefix + \
                        ":".join([str(kwargs[i]) for i in suffix])
                    r = await conn.RedisConnection.connect()
                    cache_data = await r.get(key)
                    if cache_data is not None:
                        return Helper.custom_json_response(status_code=status.HTTP_200_OK, message=Message._success, data=json.loads(jsonable_encoder(cache_data)))
                    else:
                        logger.error(f"misssss")
                        result = await func(*args, **kwargs)
                        if is_setcache is True:
                            await r.set(key, json.dumps(jsonable_encoder(json.loads(jsonable_encoder(result).get("body")).get("data"))), ex=timeout)
                        return result
                except Exception as e:
                    logger.error(f"{e}")
                    return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message=Message._server_error)
            return wrapper
        return decorator

    @classmethod
    async def set_cache(self, key: str, value:str,timeout=60) -> None:
        try:
            r = await conn.RedisConnection.connect()
            await r.set(self.__redis_namespace + key, value, ex=timeout)
        except Exception as e:
            logger.error(f"{e}")

    @classmethod
    async def get_cache(self, key: str) -> None:
        try:
            r = await conn.RedisConnection.connect()
            return await r.get(self.__redis_namespace + key)
        except Exception as e:
            logger.error(f"{e}")
    @classmethod
    async def clear_cache(self, key: str) -> None:
        try:
            r = await conn.RedisConnection.connect()
            await r.delete(self.__redis_namespace + key)
            logger.success("cleared cache")
        except Exception as e:
            logger.error(f"{e}")

    @classmethod
    async def clear_pattern_cache(self, pattern: str) -> None:
        try:
            if pattern == "":
                return
            else:
                r = await conn.RedisConnection.connect()
                [await r.delete(key) async for key in r.scan_iter(match=self.__redis_namespace + pattern)]
        except Exception as e:
            logger.error(f"{e}")
