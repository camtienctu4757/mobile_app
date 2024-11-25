from crud.repositories.file_repository import FileRepository
from crud.irepositories.ifile_repository import IFileRepository
from sqlalchemy.ext.asyncio import AsyncSession
from thirdparty.minio.storage import FileStorage
from uuid import UUID
from thirdparty.db.models.file import UserFile, ShopFile, ServiceFile
from fastapi import UploadFile
from thirdparty.db.models.shops import Shop
from thirdparty.db.models.services import Service
from typing import AsyncGenerator
from utils.helpers.helpers import Helper
from datetime import date
from thirdparty.minio.storage import FileStorage
from fastapi.responses import StreamingResponse
from sqlalchemy import select, insert, func, update, and_
import sys
from loguru import logger

sys.path.append("/")
sys.tracebacklimit = 0


class FileService(IFileRepository):
    def __init__(self, _file_repository: FileRepository):
        self.__file_repository = _file_repository

    async def get(self, db, file_id: UUID):
        try:
            return await self.__file_repository.get(db=db, file_id=file_id)
        except Exception as e:
            logger.error(f"{e}")

    async def get_all(self, db):
        try:
            return await self.__file_repository.get_all(db=db)
        except Exception as e:
            logger.error(f"{e}")

    async def add(self, db_write: AsyncSession, file, file_length: str, user_id: UUID):
        try:
            folder_path = date.today().strftime("%Y/%m/%d/")
            new_user_file = UserFile(
                file_name=Helper.sanitize_filename(file.filename),
                user_uuid=user_id,
                folder_path=folder_path,
            )
            db_write.add(new_user_file)
            await db_write.commit()
            await db_write.refresh(new_user_file)
            if new_user_file is None:
                return
            upload = await FileStorage.upload(
                file=file,
                file_length=file_length,
                file_id=str(new_user_file.file_uuid),
                folder_path=folder_path,
            )
            if not upload:
                return
            return new_user_file
        except Exception as e:
            logger.error(f"{e}")

    async def add_shop_file(
        self,
        db_write: AsyncSession,
        db_read: AsyncSession,
        file,
        file_length: str,
        shop_id: UUID,
        owner_id: UUID,
    ):
        try:
            owner = (
                await db_read.scalars(
                    select(Shop).where(
                        and_(Shop.owner_id == owner_id, Shop.shop_uuid == shop_id)
                    )
                )
            ).first()
            if owner is None:
                print("ngjrjt")
                return
            file_test = (
                await db_read.scalars(
                    select(ShopFile).where(ShopFile.shop_uuid == shop_id)
                )
            ).first()
            if file_test:
                return file_test
            folder_path = date.today().strftime("%Y/%m/%d/")
            new_shop_file = ShopFile(
                file_name=Helper.sanitize_filename(file.filename),
                shop_uuid=shop_id,
                folder_path=folder_path,
            )
            db_write.add(new_shop_file)
            await db_write.commit()
            await db_write.refresh(new_shop_file)
            if new_shop_file is None:
                return
            upload = await FileStorage.upload(
                file=file,
                file_length=file_length,
                file_id=str(new_shop_file.file_uuid),
                folder_path=folder_path,
            )
            if not upload:
                return
            return new_shop_file
        except Exception as e:
            logger.error(f"{e}")

    async def add_service_file(
        self,
        db_write: AsyncSession,
        db_read: AsyncSession,
        file,
        file_length: str,
        service_id: UUID,
        owner_id: UUID,
    ):
        try:
            service = (
                await db_read.scalars(
                    select(Service)
                    .join(Shop, Service.shop_uuid == Shop.shop_uuid)
                    .where(
                        Service.service_uuid == service_id, Shop.owner_id == owner_id
                    )
                )
            ).first()
            logger.debug(service)
            if not service:
                return
            folder_path = date.today().strftime("%Y/%m/%d/")
            new_service_file = ServiceFile(
                file_name=Helper.sanitize_filename(file.filename),
                service_uuid=service_id,
                folder_path=folder_path,
            )
            db_write.add(new_service_file)
            await db_write.commit()
            await db_write.refresh(new_service_file)
            if new_service_file is None:
                return
            upload = await FileStorage.upload(
                file=file,
                file_length=file_length,
                file_id=str(new_service_file.file_uuid),
                folder_path=folder_path,
            )
            if not upload:
                return
            return new_service_file
        except Exception as e:
            logger.error(f"{e}")

    async def update(
        self,
        db_write: AsyncSession,
        db_read: AsyncSession,
        file,
        file_length: str,
        user_id: UUID,
    ):
        try:
            file_db = (
                await db_read.scalars(
                    select(UserFile).where(UserFile.user_uuid == user_id)
                )
            ).first()
            folder_path = date.today().strftime("%Y/%m/%d/")
            file_name = Helper.sanitize_filename(file.filename)
            if file_db:
                file_db.folder_path = folder_path
                file_db.file_name = file_name
                new_user_file = (
                    update(UserFile)
                    .where(UserFile.user_uuid == user_id)
                    .values(file_db.to_dict())
                )
                await db_write.execute(new_user_file)
                await db_write.commit()
                upload = await FileStorage.upload(
                    file=file,
                    file_length=file_length,
                    file_id=str(file_db.file_uuid),
                    folder_path=folder_path,
                )
                if upload:
                    return file_db
                return
            new_user_file = UserFile(
                file_name=file_name, user_uuid=user_id, folder_path=folder_path
            )
            db_write.add(new_user_file)
            await db_write.commit()
            await db_write.refresh(new_user_file)
            upload = await FileStorage.upload(
                file=file,
                file_length=file_length,
                file_id=str(new_user_file.file_uuid),
                folder_path=folder_path,
            )
            if not upload:
                return
            return new_user_file
        except Exception as e:
            logger.error(f"{e}")

    async def update_shop_file(
        self,
        db_write: AsyncSession,
        db_read: AsyncSession,
        file,
        file_length: str,
        shop_id: UUID,
        owner_id: UUID,
    ):
        try:
            owner = (
                await db_read.scalars(
                    select(Shop).where(
                        and_(Shop.owner_id == owner_id, Shop.shop_uuid == shop_id)
                    )
                )
            ).first()
            if owner is None:
                return False
            file_test = (
                await db_read.scalars(
                    select(ShopFile).where(ShopFile.shop_uuid == shop_id)
                )
            ).first()
            folder_path = date.today().strftime("%Y/%m/%d/")
            file_name = Helper.sanitize_filename(file.filename)
            if file_test:
                file_test.folder_path = folder_path
                file_test.file_name = file_name
                new_shop_file = (
                    update(ShopFile)
                    .where(ShopFile.shop_uuid == shop_id)
                    .values(file_test.to_dict())
                )
                await db_write.execute(new_shop_file)
                await db_write.commit()
                upload = await FileStorage.upload(
                    file=file,
                    file_length=file_length,
                    file_id=str(file_test.file_uuid),
                    folder_path=folder_path,
                )
                return file_test
            new_shop_file = ShopFile(
                file_name=file_name, shop_uuid=shop_id, folder_path=folder_path
            )
            db_write.add(new_shop_file)
            await db_write.commit()
            await db_write.refresh(new_shop_file)
            upload = await FileStorage.upload(
                file=file,
                file_length=file_length,
                file_id=str(new_shop_file.file_uuid),
                folder_path=folder_path,
            )
            if not upload:
                return
            return new_shop_file
        except Exception as e:
            logger.error(f"{e}")

    async def update_service_file(
        self,
        db_write: AsyncSession,
        db_read: AsyncSession,
        file,
        file_length: str,
        service_id: UUID,
        owner_id: UUID,
    ):
        try:
            result = (
                await db_read.scalars(
                    select(Service)
                    .join(Shop, Service.shop_uuid == Shop.shop_uuid)
                    .where(
                        Service.service_uuid == service_id, Shop.owner_id == owner_id
                    )
                )
            ).first()
            if not result:
                return
            folder_path = date.today().strftime("%Y/%m/%d/")
            file_name = Helper.sanitize_filename(file.filename)
            new_service_file = ServiceFile(
                file_name=file_name,
                service_uuid=service_id,
                folder_path=folder_path + "/",
            )
            db_write.add(new_service_file)
            await db_write.commit()
            await db_write.refresh(new_service_file)
            logger.debug(new_service_file)
            upload = await FileStorage.upload(
                file=file,
                file_length=file_length,
                file_id=str(new_service_file.file_uuid),
                folder_path=folder_path,
            )
            if not upload:
                return
            return new_service_file
        except Exception as e:
            logger.error(f"{e}")

    async def delete_user_file(self, db_write: AsyncSession, user_id: UUID):
        try:
            user_file = (
                await db_write.scalars(
                    select(UserFile).where(UserFile.user_uuid == user_id)
                )
            ).first()
            if user_file:
                await db_write.delete(user_file)
                await db_write.commit()
                delete = await FileStorage.delete(
                    str(user_file.file_uuid), user_file.file_name, user_file.folder_path
                )
                if delete:
                    return True
                return False
            return False
        except Exception as e:
            logger.error(f"{e}")
            return False

    async def delete_shop_file(
        self,
        db_write: AsyncSession,
        db_read: AsyncSession,
        shop_id: UUID,
        owner_id: UUID,
    ):
        try:
            owner = (
                await db_read.scalars(
                    select(Shop).where(
                        and_(Shop.owner_id == owner_id, Shop.shop_uuid == shop_id)
                    )
                )
            ).first()
            if owner is None:
                return False
            shop_file = (
                await db_write.scalars(
                    select(ShopFile).where(ShopFile.shop_uuid == shop_id)
                )
            ).first()
            if shop_file:
                await db_write.delete(shop_file)
                await db_write.commit()
                delete = await FileStorage.delete(
                    str(shop_file.file_uuid), shop_file.file_name, shop_file.folder_path
                )
                if delete:
                    return True
                return False
            return False
        except Exception as e:
            logger.error(f"{e}")
            return False

    async def delete_service_file(
        self,
        db_write: AsyncSession,
        db_read: AsyncSession,
        service_id: UUID,
        owner: UUID,
    ):
        try:
            result = (
                await db_read.scalars(
                    select(Service)
                    .join(Shop, Service.shop_uuid == Shop.shop_uuid)
                    .where(Service.service_uuid == service_id, Shop.owner_id == owner)
                )
            ).first()
            if not result:
                return False
            service_file = (
                await db_write.scalars(
                    select(ServiceFile).where(ServiceFile.service_uuid == service_id)
                )
            ).all()
            if service_file:
                for file in service_file:
                    await db_write.delete(file)
                    await db_write.commit()
                    delete = await FileStorage.delete(
                        str(file.file_uuid), file.file_name, file.folder_path
                    )
                    if not delete:
                        return False
                return True
            return False
        except Exception as e:
            logger.error(f"{e}")
            return False

    async def dowload_user_file(self, db: AsyncSession, user_id):
        try:
            file= (
                await db.scalars(
                    select(UserFile).where(UserFile.user_uuid == user_id)
                )
            ).first()
            if file:
                file_download = await FileStorage.download(
                    file_id=str(file.file_uuid), filename=file.file_name, folder_path=file.folder_path
                )
                if file_download:
                    return StreamingResponse(
                        file_download,
                        media_type="application/octet-stream",
                        headers={"Content-Disposition": f"attachment; filename={file.file_name}"},
                    )
            else:
                return
        except Exception as e:
            logger.error(f"{e}")
            return

    async def dowload_shop_file(self, db: AsyncSession, user_id, shop_id):
        try:
            shop_id = (
                await db.scalars(
                    select(Shop.shop_uuid).where(
                        and_(Shop.owner_id == user_id, Shop.shop_uuid == shop_id)
                    )
                )
            ).first()
            if shop_id:
                file= (
                    await db.scalars(
                        select(ShopFile).where(ShopFile.shop_uuid == shop_id)
                    )
                ).first()
                if file:
                    file_download = await FileStorage.download(
                        file_id=str(file.file_uuid), filename=file.file_name, folder_path=file.folder_path
                    )
                    if file_download:
                        return StreamingResponse(
                            file_download,
                            media_type="application/octet-stream",
                            headers={
                                "Content-Disposition": f"attachment; filename={file.file_name}"
                            },
                        )
                else:
                    return
            return
        except Exception as e:
            logger.error(f"{e}")
            return

    async def dowload_service_file(
        self, db: AsyncSession, service_id, file_id
    ):
        try:
            file = (await db.scalars(select(ServiceFile).where(and_(ServiceFile.file_uuid== file_id,ServiceFile.service_uuid == service_id)))).first()
            print(file)
            if file:
                    file_download = await FileStorage.download(
                        file_id=str(file.file_uuid), filename=file.file_name, folder_path=file.folder_path
                    )
                    if file_download:
                        return StreamingResponse(
                            file_download,
                            media_type="application/octet-stream",
                            headers={
                                "Content-Disposition": f"attachment; filename={file.file_name}"
                            },
                        )
                    return
            return
        except Exception as e:
            logger.error(f"{e}")
            return
