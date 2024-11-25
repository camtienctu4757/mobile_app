
from loguru import logger
import logging
from fastapi import Request, status
from fastapi.responses import JSONResponse
from pydantic import BaseModel
from fastapi.exceptions import RequestValidationError
from fastapi import Request, status
from typing import List, Dict
from core.enviroment_params import get_env
from utils.helpers.helpers import Helper
import sys
sys.path.append('/')
sys.tracebacklimit = 0


class InterceptHandler(logging.Handler):
    """
    Default handler from examples in loguru documentaion.
    See https://loguru.readthedocs.io/en/stable/overview.html#entirely-compatible-with-standard-logging
    """

    def emit(self, record):
        # Get corresponding Loguru level if it exists
        try:
            level = logger.level(record.levelname).name
        except ValueError:
            level = record.levelno

        # Find caller from where originated the logged message
        frame, depth = logging.currentframe(), 2
        while frame.f_code.co_filename == logging.__file__:
            frame = frame.f_back
            depth += 1

        logger.opt(depth=depth, exception=record.exc_info).log(
            level, record.getMessage()
        )


class CustomErrorResponse(BaseModel):
    errors: List[Dict[str, str]]


class LogConfig():

    __log_rotation: str = get_env().FILE_LOG_ROTATION
    __log_level: str = get_env().FILE_LOG_LEVEL
    __log_retention: str = get_env().FILE_LOG_RETENTION
    __is_file_log: bool = Helper.str_to_bool(get_env().IS_FILE_LOG)
    __is_stdout_log: bool = Helper.str_to_bool(get_env().IS_STDOUT_LOG)

    @classmethod
    def config(self) -> None:
        """
        Get all logs in app:
            loggers = [logging.getLogger(name) for name in logging.root.manager.loggerDict]
        """
        try:
            # Config default log
            if self.__is_stdout_log is True:
                logger.configure(handlers=[{"sink": sys.stdout, "level": self.__log_level, "backtrace": False,
                                            "format": "{time:YYYY-MM-DD HH:mm:ss} | {level} | {name}:{function}:{line} - {message}"}])
                logging.getLogger().handlers = [InterceptHandler()]
                logging.getLogger("uvicorn.access").handlers = [
                    InterceptHandler()]
                logging.getLogger("uvicorn.error").handlers = [
                    InterceptHandler()]
                # Disable dupplicate error log
                logging.getLogger("uvicorn.error").propagate = False
            else:
                # Disable default log
                logging.getLogger("uvicorn.access").disabled = True
                logging.getLogger("uvicorn.error").disabled = True
            # Add new log ( using loguru )
            if self.__is_file_log is True:
                logger.bind(name="file_log").add('./logs/app.log', format="{time:YYYY-MM-DD HH:mm:ss} | {level} | {name}:{function}:{line} - {message}",
                                                 level=self.__log_level, serialize=True, rotation=self.__log_rotation,
                                                 retention=self.__log_retention, compression="zip")
        except Exception as e:
            logger.error(f"{e}")
            sys.exit(1)

    @classmethod
    def custom_validation_exception_handler(self, request: Request, exc: RequestValidationError) -> JSONResponse:
        try:
            custom_errors = [{"fields": ".".join(map(str, e['loc'])), "detail": f"{
                e['msg']}"} for e in exc.errors()]
            custom_response = CustomErrorResponse(errors=custom_errors)
            return JSONResponse(
                status_code=status.HTTP_422_UNPROCESSABLE_ENTITY,
                content=custom_response.model_dump()
            )
        except Exception as e:
            logger.error(f"{e}")
