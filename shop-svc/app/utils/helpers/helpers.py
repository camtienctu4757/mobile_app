import sys
import time
from functools import wraps
from loguru import logger
from typing import Callable
from fastapi.responses import JSONResponse
import os
import re
import json
from io import BytesIO
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
    def custom_error_json_response(self, status_code: int, message_error: str) -> JSONResponse:
        try:
            return JSONResponse(status_code=status_code, content={"message": message_error, "data": None})
        except Exception as e:
            logger.error(f"{e}")

    
    @classmethod
    def custom_json_response(self, status_code: int, message: str, data: str) -> JSONResponse:
        try:
            return JSONResponse(status_code=status_code, content={"message": message,"data": data})
        except Exception as e:
            logger.error(f"{e}")
    @classmethod
    def sanitize_filename(self, filename: str) -> str:
        max_filename_length = 150
        filename = os.path.basename(filename)
        # Replace any invalid characters with an underscore
        filename = re.sub(r'[^a-zA-Z0-9_.-]', '_', filename)
        # Enforce a max filename length
        filename = filename[-max_filename_length:]
        return filename
    
    @classmethod
    async def validate_image_file(self,file: BytesIO,content_type: str) -> bool:
        # call method seek(0) to move to the beginning of the file
        if content_type in ["image/jpeg","image/png","image/gif","image/svg+xml"]:
            header = await file.read(10)
            await file.seek(0)
            logger.info(header)
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
    def is_json_string(json_string: str):
        try:
            json.loads(json_string)
            return True
        except json.JSONDecodeError:
            return False
