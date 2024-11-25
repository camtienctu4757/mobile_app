import sys
from abc import ABC, abstractmethod
from sqlalchemy.ext.asyncio import AsyncSession
from typing import AsyncGenerator
from thirdparty.db.sessions import PostgresDBManager
from sqlalchemy import text
from loguru import logger
sys.path.append('/')
sys.tracebacklimit = 0


class ThirdpartyConnections(ABC):

    @abstractmethod
    async def connect(self):
        pass

    @abstractmethod
    def check_status(self):
        pass

    @abstractmethod
    def disconnect(self):
        pass


class PostgresConnection(ThirdpartyConnections):
    # Using wrapper function for  the depend injection
    @classmethod
    def connect(self, db_type: str) -> AsyncGenerator[AsyncSession, None]:
        try:
            if db_type == "read":
                async def get_read_connect() -> AsyncGenerator[AsyncSession, None]:
                    async with PostgresDBManager().get_session(db_type=db_type) as db:
                        yield db
                return get_read_connect
            elif db_type == "write":
                async def get_write_connect() -> AsyncGenerator[AsyncSession, None]:
                    async with PostgresDBManager().get_session(db_type=db_type) as db:
                        yield db
                return get_write_connect
            else:
                raise Exception(f"There is not type db: {db_type} ")
        except Exception as e:
            logger.error(f"Failed to connect to Postgres: {e}")
            sys.exit(1)

    @classmethod
    async def check_status(self) -> None:
        try:
            async with PostgresDBManager().get_session(db_type="read") as read_db:
                await read_db.execute(text("SELECT 1"))
            async with PostgresDBManager().get_session(db_type="write") as write_db:
                await write_db.execute(text("SELECT 1"))
        except Exception as e:
            logger.error(f"Failed to check status Postgres: {e}")
            sys.exit(1)

    @classmethod
    async def disconnect(self) -> None:
        await PostgresDBManager().disconnect_engine()

