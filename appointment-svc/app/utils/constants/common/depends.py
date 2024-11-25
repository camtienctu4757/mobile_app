from fastapi import Depends
from sqlalchemy.orm import Session
from sqlalchemy.ext.asyncio import AsyncSession
from thirdparty.connections import PostgresConnection
from typing_extensions import Annotated


class Depend():
    _async_read_db_dep = Annotated[AsyncSession,
                                   Depends(PostgresConnection.connect(db_type="read"))]
    _async_write_db_dep = Annotated[AsyncSession, Depends(
        PostgresConnection.connect(db_type="write"))]
    