import json
import sys
import time
from functools import wraps
from loguru import logger
from typing import Callable
from core.enviroment_params import get_env
import thirdparty.connections as conn
from fastapi import status
from io import BytesIO

from fastapi.encoders import jsonable_encoder

from utils.helpers.helpers import Helper
from utils.constants.message import Message
sys.path.append('/')
sys.tracebacklimit = 0


class FileStorage():
    _minio_bucket_name: str = get_env().MINIO_BUCKET

    @classmethod
    async def download(self, filename: str, folder_path: str) -> object:
        try:
            m = await conn.MinioConnection.connect()
            return m.get_object(self._minio_bucket_name, f"{folder_path + filename}")
        except Exception as e:
            logger.error(f"{e}")

    @classmethod
    async def upload(self, file, filename: str, folder_path: str) -> bool:
        try:
            if folder_path == "":
                return False
            else:
                m = await conn.MinioConnection.connect()
                m.put_object(
                    self._minio_bucket_name,
                    folder_path + filename,
                    data=BytesIO(file),
                    length=len(file)
                )
                if m.stat_object(self._minio_bucket_name, f"{folder_path + filename}"):
                    return True
                else:
                    return False
        except Exception as e:
            logger.error(f"{e}")
