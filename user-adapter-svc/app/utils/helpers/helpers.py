import json
import sys
import time
from functools import wraps
from loguru import logger
from typing import Callable
from fastapi.responses import JSONResponse

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
    # @classmethod
    # def mapper_usermodel_to_userwithrole(self, user:User, role_list:list[str]):
    #     return UserOutRoles(user_uuid=user.user_uuid,
    #         username=user.username,
    #         password=user.password,
    #         email=user.email,
    #         phone_number=user.phone_number,
    #         firstname=user.firstname,
    #         lastname=user.lastname,
    #         is_enabled=user.is_enabled, roles=role_list)
