from utils.constants.enum import Tags
from uuid import UUID
from fastapi import APIRouter, status, File, UploadFile, Form, Depends
from thirdparty.minio.storage import FileStorage
from crud.services.file_service import FileService
from crud.repositories.file_repository import FileRepository
from typing import Union,Optional
from utils.constants.urls import Urls
from schemas.respones.file_dto import fileout
from fastapi.responses import StreamingResponse
from fastapi.encoders import jsonable_encoder
from loguru import logger
from utils.constants.message import Message
from utils.helpers.helpers import Helper
from utils.constants.common.depends import Depend
from core.security import SecurityOauth2
import uuid
import sys

sys.path.append("/")
router = APIRouter()
_file_service = FileService(FileRepository)

# setup.exe
# setup

@router.post(Urls._upload_user_file, tags=[Tags.Files.value])
async def upload_user_file(
    db_write: Depend._async_write_db_dep,
    file: UploadFile = File(...),
    user_id: UUID = Form(...),
    user_infor: dict = Depends(SecurityOauth2(roles=["public"]))
):
    try:
        if uuid.UUID(str(user_infor['sub']).split(':')[-1]) == user_id:
            MAX_FILE_SIZE = 100 * 1024 * 1024
            file_length = len(await file.read())
            await file.seek(0)
            if file_length > MAX_FILE_SIZE:
                return Helper.custom_error_json_response(
                    status_code=status.HTTP_400_BAD_REQUEST, message=Message._file_too_large
                )
            if not await Helper.validate_image_file(file, content_type=file.content_type):
                return Helper.custom_error_json_response(
                    status_code=status.HTTP_400_BAD_REQUEST, message=Message._file_unsupport
                )
            result = await _file_service.add(
                db_write=db_write, file=file, file_length=file_length, user_id=user_id
            )
            if result is not None:
                print(type(result))
                return Helper.custom_json_response(
                    status_code=status.HTTP_201_CREATED,
                    message=Message._file_sucess,
                    data=jsonable_encoder(fileout.model_validate(result)),
                )
            return Helper.custom_error_json_response(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                message=Message._file_error,
            )
        return Helper.custom_error_json_response(status_code= status.HTTP_401_UNAUTHORIZED,message=Message._fail_authentication)
    except Exception as e:
        print(e)
        return Helper.custom_error_json_response(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            message=Message._server_error,
        )
    finally:
        await file.close()


@router.post(Urls._upload_shop_file, tags=[Tags.Files.value])
async def upload_shop_file(
    db_write: Depend._async_write_db_dep,
    db_read: Depend._async_read_db_dep,
    file: UploadFile = File(...),
    shop_id: UUID = Form(...),
    user_infor: dict = Depends(SecurityOauth2(roles=["shop"]))
):
    try:
        MAX_FILE_SIZE = 100 * 1024 * 1024
        file_length = len(await file.read())
        await file.seek(0)
        if file_length > MAX_FILE_SIZE:
            return Helper.custom_error_json_response(
                status_code=status.HTTP_400_BAD_REQUEST, message=Message._file_too_large
            )
        if not await Helper.validate_image_file(file, content_type=file.content_type):
            return Helper.custom_error_json_response(
                status_code=status.HTTP_400_BAD_REQUEST, message=Message._file_unsupport
            )
        result = await _file_service.add_shop_file(
            db_write=db_write,
            db_read=db_read,
            file=file,
            file_length=file_length,
            shop_id=shop_id,
            owner_id = uuid.UUID(str(user_infor['sub']).split(':')[-1])
        )
        if result is not None:
            return Helper.custom_json_response(
                status_code=status.HTTP_201_CREATED,
                message=Message._file_sucess,
                data=jsonable_encoder(fileout.model_validate(result)),
            )
        return Helper.custom_error_json_response(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            message=Message._file_error,
        )
    except Exception as e:
        print(e)
        return Helper.custom_error_json_response(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            message=Message._server_error,
        )
    finally:
        await file.close()

@router.post(Urls._upload_service_file, tags=[Tags.Files.value])
async def upload_service_file(
    db_write: Depend._async_write_db_dep,
    db_read: Depend._async_read_db_dep,
    file1: UploadFile = File(...),
    file2: Optional[UploadFile] = File(None),
    file3: Optional[UploadFile] = File(None),   
    service_id: UUID = Form(...),
    user_infor: dict = Depends(SecurityOauth2(roles=["shop"]))
):
    try:
        files = [file1, file2, file3]
        final = []
        MAX_FILE_SIZE = 100 * 1024 * 1024
        for idx, file in enumerate(files, start=1):
            if file is not None:
                file_length = len(await file.read())
                await file.seek(0)
                if file_length > MAX_FILE_SIZE:
                    return Helper.custom_error_json_response(
                        status_code=status.HTTP_400_BAD_REQUEST,
                        message=Message._file_too_large,
                    )
                if not await Helper.validate_image_file(
                    file, content_type=file.content_type
                ):
                    return Helper.custom_error_json_response(
                        status_code=status.HTTP_400_BAD_REQUEST,
                        message=Message._file_unsupport,
                    )
                result = await _file_service.add_service_file(
                    db_write=db_write,
                    db_read= db_read,
                    file=file,
                    file_length=file_length,
                    service_id=service_id,
                    owner_id = uuid.UUID(str(user_infor['sub']).split(':')[-1])
                )
                if result:
                    final.append(fileout.model_validate(result))
                await file.close()
        if final:
            return Helper.custom_json_response(
                status_code=status.HTTP_201_CREATED,
                message=Message._file_sucess,
                data=jsonable_encoder(final),
            )
        return Helper.custom_error_json_response(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            message=Message._file_error,
        )

    except Exception as e:
        print(e)
        return Helper.custom_error_json_response(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            message=Message._server_error,
        )
    


@router.patch(Urls._update_user_file, tags=[Tags.Files.value])
async def update_user_file(
    db_write: Depend._async_write_db_dep,
    db_read: Depend._async_read_db_dep,
    file: UploadFile = File(...),
    user_id: UUID = Form(...),
    user_infor: dict = Depends(SecurityOauth2(roles=["public"]))
):
    try:
        if uuid.UUID(str(user_infor['sub']).split(':')[-1]) == user_id:
            MAX_FILE_SIZE = 100 * 1024 * 1024
            file_length = len(await file.read())
            await file.seek(0)
            if file_length > MAX_FILE_SIZE:
                return Helper.custom_error_json_response(
                    status_code=status.HTTP_400_BAD_REQUEST, message=Message._file_too_large
                )
            if not await Helper.validate_image_file(file, content_type=file.content_type):
                return Helper.custom_error_json_response(
                    status_code=status.HTTP_400_BAD_REQUEST, message=Message._file_unsupport
                )
            result = await _file_service.update(
                db_write=db_write,db_read=db_read, file=file, file_length=file_length, user_id=user_id
            )
            if result is not None:
                print(type(result))
                return Helper.custom_json_response(
                    status_code=status.HTTP_201_CREATED,
                    message=Message._file_sucess,
                    data=jsonable_encoder(fileout.model_validate(result)),
                )
            return Helper.custom_error_json_response(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                message=Message._file_error,
            )
        return Helper.custom_error_json_response(status_code= status.HTTP_401_UNAUTHORIZED,message=Message._fail_authentication)
    except Exception as e:
        print(e)
        return Helper.custom_error_json_response(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            message=Message._server_error,
        )
    finally:
        await file.close()




@router.patch(Urls._update_shop_file, tags=[Tags.Files.value])
async def update_shop_file(
    db_write: Depend._async_write_db_dep,
    db_read: Depend._async_read_db_dep,
    file: UploadFile = File(...),
    shop_id: UUID = Form(...),
    user_infor: dict = Depends(SecurityOauth2(roles=["shop"]))
):
    try:
        MAX_FILE_SIZE = 100 * 1024 * 1024
        file_length = len(await file.read())
        await file.seek(0)
        if file_length > MAX_FILE_SIZE:
            return Helper.custom_error_json_response(
                status_code=status.HTTP_400_BAD_REQUEST, message=Message._file_too_large
            )
        if not await Helper.validate_image_file(file, content_type=file.content_type):
            return Helper.custom_error_json_response(
                status_code=status.HTTP_400_BAD_REQUEST, message=Message._file_unsupport
            )
        result = await _file_service.update_shop_file(
            db_write=db_write,
            db_read=db_read,
            file=file,
            file_length=file_length,
            shop_id=shop_id,
            owner_id = uuid.UUID(str(user_infor['sub']).split(':')[-1])
        )
        if result is not None:
            return Helper.custom_json_response(
                status_code=status.HTTP_200_OK,
                message=Message._file_sucess,
                data=jsonable_encoder(fileout.model_validate(result)),
            )
        return Helper.custom_error_json_response(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            message=Message._file_error,
        )
    except Exception as e:
        print(e)
        return Helper.custom_error_json_response(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            message=Message._server_error,
        )
    finally:
        await file.close()


@router.patch(Urls._update_service_file, tags=[Tags.Files.value])
async def update_service_file(
    db_write: Depend._async_write_db_dep,
    db_read: Depend._async_read_db_dep,
    file1: UploadFile = File(...),
    file2: Optional[UploadFile] = File(None),
    file3: Optional[UploadFile] = File(None),   
    service_id: UUID = Form(...),
    user_infor: dict = Depends(SecurityOauth2(roles=["shop"]))
):
    try:
        files = [file1, file2, file3]
        final = []
        await _file_service.delete_service_file(db_write,db_read,service_id,uuid.UUID(str(user_infor['sub']).split(':')[-1]))
        MAX_FILE_SIZE = 100 * 1024 * 1024
        for idx, file in enumerate(files, start=1):
            if file is not None:
                file_length = len(await file.read())
                await file.seek(0)
                if file_length > MAX_FILE_SIZE:
                    return Helper.custom_error_json_response(
                        status_code=status.HTTP_400_BAD_REQUEST,
                        message=Message._file_too_large,
                    )
                if not await Helper.validate_image_file(
                    file, content_type=file.content_type
                ):
                    return Helper.custom_error_json_response(
                        status_code=status.HTTP_400_BAD_REQUEST,
                        message=Message._file_unsupport,
                    )
                result = await _file_service.update_service_file(
                    db_write=db_write,
                    db_read= db_read,
                    file=file,
                    file_length=file_length,
                    service_id=service_id,
                    owner_id = uuid.UUID(str(user_infor['sub']).split(':')[-1])
                )
                if result is not None:
                    final.append(fileout.model_validate(result))
                await file.close()
        if final:
            return Helper.custom_json_response(
                status_code=status.HTTP_201_CREATED,
                message=Message._file_sucess,
                data=jsonable_encoder(final),
            )
        return Helper.custom_error_json_response(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            message=Message._file_error,
        )
    except Exception as e:
        print(e)
        return Helper.custom_error_json_response(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            message=Message._server_error,
        )
@router.delete(Urls._delete_user_file, tags=[Tags.Files.value])
async def delete_user_file(
    db_write: Depend._async_write_db_dep,
    user_id: UUID = Form(...),
    user_infor: dict = Depends(SecurityOauth2(roles=["public"]))
):
    try:
        if uuid.UUID(str(user_infor['sub']).split(':')[-1]) == user_id:
            result = await _file_service.delete_user_file(
                db_write=db_write, user_id=user_id
            )
            if result:
                return Helper.custom_json_response(
                    status_code=status.HTTP_200_OK,
                    message=Message._delete_success,
                    data="",
                )
            return Helper.custom_error_json_response(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                message=Message._delete_fail,
            )
        return Helper.custom_error_json_response(status_code= status.HTTP_401_UNAUTHORIZED,message=Message._fail_authentication)
    except Exception as e:
        logger.error(e)
        return Helper.custom_error_json_response(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            message=Message._delete_fail,
        )

@router.delete(Urls._delete_shop_file, tags=[Tags.Files.value])
async def delete_shop_file(
    db_write: Depend._async_write_db_dep,
    db_read: Depend._async_read_db_dep,
    shop_id: UUID = Form(...),
    user_infor: dict = Depends(SecurityOauth2(roles=["shop"]))
):
    try:
        result = await _file_service.delete_shop_file(
                db_write=db_write,db_read = db_read, shop_id=shop_id, owner_id = uuid.UUID(str(user_infor['sub']).split(':')[-1])
            )
        if result:
            return Helper.custom_json_response(
                status_code=status.HTTP_200_OK,
                 message=Message._delete_success,
                 data="",
                )
        return Helper.custom_error_json_response(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                message=Message._delete_fail,
            )
    except Exception as e:
        return Helper.custom_error_json_response(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            message=Message._delete_fail,
        )

@router.delete(Urls._delete_service_file, tags=[Tags.Files.value])
async def delete_service_file(
    db_write: Depend._async_write_db_dep,
    db_read: Depend._async_read_db_dep,
    service_id: UUID = Form(...),
    user_infor: dict = Depends(SecurityOauth2(roles=["shop"]))
):
    try:
        result = await _file_service.delete_service_file(
                db_write=db_write,db_read = db_read, service_id=service_id, owner = uuid.UUID(str(user_infor['sub']).split(':')[-1])
            )
        if result:
            return Helper.custom_json_response(
                status_code=status.HTTP_200_OK,
                 message=Message._delete_success,
                 data="",
                )
        return Helper.custom_error_json_response(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                message=Message._delete_fail,
            )
    except Exception as e:
        return Helper.custom_error_json_response(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            message=Message._delete_fail,
        )

@router.get(Urls._download_shop_file, tags=[Tags.Files.value])
async def download_shop_file(db_read: Depend._async_read_db_dep, shop_id:str,user_infor: dict = Depends(SecurityOauth2(roles=["shop"]))):
    try:
        file = await _file_service.dowload_shop_file(db_read,uuid.UUID(str(user_infor['sub']).split(':')[-1]),shop_id)
        if file:
            return file
        else:
            return Helper.custom_error_json_response(
                status_code=status.HTTP_404_NOT_FOUND, message=Message._no_content
            )
    except Exception:
        return Helper.custom_error_json_response(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            message=Message._server_error,
        )

@router.get(Urls._download_user_file, tags=[Tags.Files.value])
async def download_user_file(db_read: Depend._async_read_db_dep,user_infor: dict = Depends(SecurityOauth2(roles=["public"]))):
    try:
        file = await _file_service.dowload_user_file(db_read,uuid.UUID(str(user_infor['sub']).split(':')[-1]))
        if file:
            return file
        else:
            return Helper.custom_error_json_response(
                status_code=status.HTTP_404_NOT_FOUND, message=Message._no_content
            )
    except Exception:
        return Helper.custom_error_json_response(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            message=Message._server_error,
        )
    
@router.get(Urls._download_service_file, tags=[Tags.Files.value])
async def download_service_file(db_read: Depend._async_read_db_dep,file_id: str,service_id: str, user_infor: dict = Depends(SecurityOauth2(roles=["public"]))):
    try:
        file = await _file_service.dowload_service_file(db_read,service_id,file_id)
        if file:
            return file
        else:
            return Helper.custom_error_json_response(
                status_code=status.HTTP_404_NOT_FOUND, message=Message._no_content
            )
    except Exception:
        return Helper.custom_error_json_response(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            message=Message._server_error,
        )
