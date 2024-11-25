import sys
from loguru import logger
from core.enviroment_params import get_env
import thirdparty.connections as conn
from io import BytesIO
import os
import re
sys.path.append('/')
sys.tracebacklimit = 0


class FileStorage():
    __minio_bucket_name: str = get_env().MINIO_BUCKET
    __max_filename_length: int  = 150

    def __sanitize_filename(self, filename: str) -> str:
        filename = os.path.basename(filename)
        # Replace any invalid characters with an underscore
        filename = re.sub(r'[^a-zA-Z0-9_.-]', '_', filename)
        # Enforce a max filename length
        filename = filename[-self.__max_filename_length:]
        return filename
    
    @classmethod
    async def download(self, file_id: str, filename: str, folder_path: str) -> object:
        try:
            m = await conn.MinioConnection.connect()
            return m.get_object(self.__minio_bucket_name, f"{folder_path + file_id + "_" + filename}")
        except Exception as e:
            logger.error(f"{e}")

    @classmethod
    async def upload(self, file: BytesIO, file_length:str, file_id: str, folder_path: str) -> bool:
        try:
            if folder_path == "":
                return False
            else:
                filename = self.__sanitize_filename(self,filename=file.filename)
                m = await conn.MinioConnection.connect()
                m.put_object(
                    self.__minio_bucket_name,
                    folder_path + file_id + "_" + filename,
                    data=BytesIO(await file.read()),
                    length=file_length
                )
                if m.stat_object(self.__minio_bucket_name, f"{folder_path + file_id + "_" + filename}"):
                    return True
                else:
                    return False
        except Exception as e:
            logger.error(f"{e}")
    
    @classmethod
    async def delete(cls, file_id: str, filename: str, folder_path: str) -> bool:
        try:
            m = await conn.MinioConnection.connect()
            m.remove_object(cls.__minio_bucket_name, f"{folder_path + file_id + '_' + filename}")
            return True
        except Exception as e:
            logger.error(f"Lỗi khi xóa tệp: {e}")
            return False

            