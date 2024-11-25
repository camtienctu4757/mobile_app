
from thirdparty.connections import PostgresConnection
from contextlib import asynccontextmanager
from loguru import logger
import sys
from fastapi import FastAPI
from pydantic import ValidationError
from fastapi.exceptions import RequestValidationError
from utils.constants.enum import ApiVersion
from routers.v1.endpoints import healthcheck, user
from utils.helpers.logger import LogConfig
from core.enviroment_params import get_env
sys.path.append('/')


@asynccontextmanager
async def lifespan(app: FastAPI):
    LogConfig.config()
    logger.info("Configuring log successully!")
    await PostgresConnection.check_status()
    logger.info("Connecting the Postgres database successully!")
    yield
    await PostgresConnection.disconnect()
    logger.info("The redis connection was closed!")


def get_application() -> FastAPI:
    application = FastAPI(
        title="Blah blah",
        summary="All is free!",
        version="1.0.0",
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
    application.include_router(user.router, prefix=ApiVersion.v1.value)

    # application.add_middleware(
    #     CORSMiddleware,
    #     allow_origins=['*'],
    #     allow_credentials=True,
    #     allow_methods=["*"],
    #     allow_headers=["*"],
    # )
    return application
