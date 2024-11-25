import json
import sys
import time
from functools import wraps
from loguru import logger
from typing import Callable
from datetime import datetime, timedelta
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
    def create_timeslots_for_service(service_id, start_date, num_days=3, start_time="09:00", end_time="17:00", slot_duration=30):
        timeslots = []
        start_time_obj = datetime.strptime(start_time, "%H:%M").time()
        end_time_obj = datetime.strptime(end_time, "%H:%M").time()
        for day in range(num_days):
            current_date = start_date + timedelta(days=day)
            current_start_time = datetime.combine(current_date, start_time_obj)
            current_end_time = datetime.combine(current_date, end_time_obj)
            while current_start_time + timedelta(minutes=slot_duration) <= current_end_time:
                timeslot = {
                    "service_id": service_id,
                    "date": current_date.date(),
                    "start_time": current_start_time.time(),
                    "end_time": (current_start_time + timedelta(minutes=slot_duration)).time(),
                    "status": "available"
                }
                timeslots.append(timeslot)
                current_start_time += timedelta(minutes=slot_duration)
        
        # Lưu timeslot vào cơ sở dữ liệu (phần này sẽ phụ thuộc vào cấu trúc và thư viện bạn dùng)
        # save_timeslots_to_db(timeslots)
