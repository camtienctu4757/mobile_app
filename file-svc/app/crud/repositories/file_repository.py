from crud.irepositories.ifile_repository import IFileRepository
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from uuid import UUID
from loguru import logger
import sys
sys.path.append('/')
sys.tracebacklimit = 0


class FileRepository(IFileRepository):
    async def add(self, db: AsyncSession, file):
        pass