from core.enviroment_params import get_env
from contextlib import asynccontextmanager
import asyncio
import ssl
from loguru import logger
from sqlalchemy.orm import sessionmaker, scoped_session
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.ext.asyncio import AsyncSession, create_async_engine, AsyncEngine
from utils.helpers.helpers import Helper
from utils.helpers.singleton import SingletonMeta
from typing import AsyncGenerator
import sys
sys.path.append('/')
sys.tracebacklimit = 0

class PostgresDBManager(metaclass=SingletonMeta):

    Base = declarative_base()
    __read_db_url: str = get_env().PG_READ_URL
    __read_db_pool_size: int = int(get_env().PG_READ_POOL_SIZE)
    __read_db_pool_recycle: int = int(get_env().PG_READ_POOL_RECYCLE)
    __read_db_pool_timeout: int = int(get_env().PG_READ_POOL_TIMEOUT)
    __read_db_max_overflow: int = int(get_env().PG_READ_MAX_OVERFLOW)
    __write_db_url: str = get_env().PG_WRITE_URL
    __write_db_pool_size: int = int(get_env().PG_WRITE_POOL_SIZE)
    __write_db_pool_recycle: int = int(get_env().PG_WRITE_POOL_RECYCLE)
    __write_db_pool_timeout: int = int(get_env().PG_WRITE_POOL_TIMEOUT)
    __write_db_max_overflow: int = int(get_env().PG_WRITE_MAX_OVERFLOW)
    __pg_cert_file: str = get_env().PG_CERT_FILE
    __pg_key_file: str = get_env().PG_KEY_FILE
    __pg_ca_file: str = get_env().PG_CA_FILE
    __pg_ssl: bool = Helper.str_to_bool(get_env().PG_SSL)

    def __init__(self):
        self.__read_engine: AsyncEngine = None
        self.__write_engine: AsyncEngine = None
        self.__read_connect_args: dict = {}
        self.__write_connect_args: dict = {}
        self.get_ssl_context()

    async def create_read_engine(self) -> AsyncEngine:
        try:
            if self.__read_engine is None:
                self.__read_engine = create_async_engine(self.__read_db_url, connect_args=self.__read_connect_args,
                                                         pool_recycle=self.__read_db_pool_recycle, pool_pre_ping=True, future=True,
                                                         pool_size=self.__read_db_pool_size, max_overflow=self.__read_db_max_overflow, pool_timeout=self.__read_db_pool_timeout
                                                         )
            return self.__read_engine
        except Exception as e:
            logger.error(f"Failed to create the read Postgres engine: {e}")
            sys.exit(1)

    async def create_write_engine(self) -> AsyncEngine:
        try:
            if self.__write_engine is None:
                self.__write_engine = create_async_engine(self.__write_db_url, connect_args=self.__write_connect_args,
                                                          pool_recycle=self.__write_db_pool_recycle, pool_pre_ping=True, future=True,
                                                          pool_size=self.__write_db_pool_size, max_overflow=self.__write_db_max_overflow, pool_timeout=self.__write_db_pool_timeout
                                                          )
            return self.__write_engine
        except Exception as e:
            logger.error(f"Failed to create the write Postgres engine: {e}")
            sys.exit(1)

    async def get_read_session(self) -> AsyncSession:
        try:
            return scoped_session(sessionmaker(bind=await self.create_read_engine(), class_=AsyncSession, expire_on_commit=False,
                                               autoflush=False, autocommit=False))()
        except Exception as e:
            logger.error(f"Failed to create the read Postgres session: {e}")
            sys.exit(1)

    async def get_write_session(self) -> AsyncSession:
        try:
            return scoped_session(sessionmaker(bind=await self.create_write_engine(), class_=AsyncSession, expire_on_commit=False,
                                               autoflush=False, autocommit=False))()
        except Exception as e:
            logger.error(f"Failed to create the write Postgres session: {e}")
            sys.exit(1)

    @asynccontextmanager
    async def get_session(self, db_type: str) -> AsyncGenerator[AsyncSession, any]:
        if db_type == "read":
            db = await self.get_read_session()
        elif db_type == "write":
            db = await self.get_write_session()
        else:
            raise Exception(f"There is not type db: {db_type} ")
        try:
            yield db
        finally:
            await db.close()

    async def disconnect_engine(self) -> None:
        try:
            async with asyncio.TaskGroup() as tg:
                if self.__read_engine is not None:
                    tg.create_task(self.__read_engine.dispose())
                if self.__write_engine is not None:
                    tg.create_task(self.__write_engine.dispose())
        except Exception as e:
            logger.error(f"Failed to disconnect the Postgres engine: {e}")
            sys.exit(1)

    def get_ssl_context(self) -> None:
        try:
            if self.__pg_ssl is True:
                ssl_context = ssl.create_default_context()
                ssl_context.verify_mode = ssl.CERT_REQUIRED
                ssl_context.load_cert_chain(
                    certfile=self.__pg_cert_file, keyfile=self.__pg_key_file)
                ssl_context.load_verify_locations(
                    cafile=self.__pg_ca_file)
                self.__read_connect_args['ssl'] = ssl_context
                self.__write_connect_args['ssl'] = ssl_context
        except Exception as e:
            logger.error(f"Failed to get ssl context: {e}")
            sys.exit(1)
