import json
import sys
import time
from functools import wraps
from loguru import logger
from typing import Callable
from fastapi.responses import JSONResponse
from io import BytesIO
import os
import re
sys.path.append('/')
sys.tracebacklimit = 0


class Helper():
    @classmethod
    def measure_time(self, route: str = ""):
        def decorator(func: Callable):
            @wraps(func)
            async def wrapper(*args, **kwargs):
                start_time = time.perf_counter()
                result = await func(*args, **kwargs)
                end_time = time.perf_counter()
                elapsed_time = end_time - start_time
                if route:
                    logger.debug(f"Api === {route} === executed in {
                                 elapsed_time:.4f} seconds")
                else:
                    logger.debug(f"Function   {func.__name__}()   executed in {
                                 elapsed_time:.4f} seconds")
                return result
            return wrapper
        return decorator

    @classmethod
    def str_to_bool(self, s: str) -> bool:
        try:
            return s.lower() in ("true", "yes", "1")
        except Exception as e:
            logger.error(f"{e}")

    @classmethod
    def custom_error_json_response(self, status_code: int, message: str) -> JSONResponse:
        try:
            return JSONResponse(status_code=status_code, content={"message": message, "data": None})
        except Exception as e:
            logger.error(f"{e}")

    @classmethod
    def custom_json_response(self, status_code: int, message: str, data: str) -> JSONResponse:
        try:
            return JSONResponse(status_code=status_code, content={"message": message,"data": data})
        except Exception as e:
            logger.error(f"{e}")

    @classmethod
    async def validate_pdf_file(self,file: BytesIO,content_type: str) -> bool:
        # call method seek(0) to move to the beginning of the file
        if content_type == "application/pdf":
            header = await file.read(10)
            await file.seek(0)
            if header.startswith(b'%PDF'):
                return True 
        return False

    @classmethod
    async def validate_image_file(self,file: BytesIO,content_type: str) -> bool:
        # call method seek(0) to move to the beginning of the file
        if content_type in ["image/jpeg","image/png","image/gif","image/svg+xml"]:
            header = await file.read(10)
            await file.seek(0)
            # logger.info(header)
            # png file
            if header.startswith(b'\x89PNG\r\n\x1a\n'):
                return True 
            # jpeg file
            if header.startswith(b'\xff\xd8\xff\xe0'):
                return True         
            # gif file
            if header.startswith(b'GIF87a') or header.startswith(b'GIF89a'):
                return True 
        return False

    @classmethod
    async def validate_word_file(self,file: BytesIO,content_type: str) -> bool:
        # call method seek(0) to move to the beginning of the file
        if content_type in ["application/msword", "application/vnd.openxmlformats-officedocument.wordprocessingml.document"]:
            header = await file.read(10) 
            await file.seek(0)
            if header.startswith(b'\xD0\xCF\x11\xE0\xA1\xB1\x1A\xE1') or header.startswith(b'\x50\x4B\x03\x04'):
                return True
        return False

    @classmethod
    async def validate_excel_file(self,file: BytesIO,content_type: str) -> bool:
        # call method seek(0) to move to the beginning of the file
        if content_type in ["application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
                        "application/vnd.ms-excel",
                        "application/vnd.oasis.opendocument.spreadsheet"]:
            header = await file.read(10)
            await file.seek(0)
            if  header.startswith(b'\xD0\xCF') or header.startswith(b'\x50\x4B\x03\x04'):
                return True
        return False

    @classmethod
    async def validate_video_file(self,file: BytesIO,content_type: str) -> bool:
        # call method seek(0) to move to the beginning of the file
        if content_type in ["video/mp4","video/avi","video/x-msvideo","video/x-matroska","video/quicktime","video/x-flv","video/webm","video/x-ms-wmv","video/3gpp","video/mpeg"]:
            header = await file.read(10)
            await file.seek(0)
            logger.info(header)
            # mp4 file
            if  header.startswith(b'\x00\x00\x00\x20ftyp') or header.startswith(b'\x00\x00\x00\x18ftyp') or header.startswith(b'\x00\x00\x00 ftypmp'):
                return True
            # avi file
            if  header.startswith(b'RIFF'):
                return True
            # mkv and webm file
            if  header.startswith(b'\x1A\x45\xDF\xA3'):
                return True
            # mov file
            if  header.startswith(b'\x00\x00\x00\x14ftypqt'):
                return True
            # flv file
            if  header.startswith(b'FLV'):
                return True
            # wmv file
            if  header.startswith(b'\x30\x26\xB2\x75'):
                return True
            # 3gp file
            if  header.startswith(b'\x66\x74\x79\x70'):
                return True
            # mpeg file
            if  header.startswith(b'\x00\x00\x01\xBA'):
                return True
        return False
    
    @classmethod
    def sanitize_filename(self, filename: str) -> str:
        max_filename_length = 150
        filename = os.path.basename(filename)
        # Replace any invalid characters with an underscore
        filename = re.sub(r'[^a-zA-Z0-9_.-]', '_', filename)
        # Enforce a max filename length
        filename = filename[-max_filename_length:]
        return filename
