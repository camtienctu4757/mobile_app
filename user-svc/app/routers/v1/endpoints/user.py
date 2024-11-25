from utils.constants.enum import Tags
from utils.constants.urls import Urls
from fastapi import APIRouter, status, Depends,Form
from utils.constants.common.depends import Depend as Dep
from crud.services.user_service import UserService
from crud.repositories.user_repository import UserRepository
from schemas.respones.user_dto import UserOut
from schemas.requests.user_dto import TokenUser
from thirdparty.redis.caching import RedisCaching
from fastapi.encoders import jsonable_encoder
import uuid
from uuid import UUID
import sys
import json
from core.security import SecurityOauth2
from schemas.requests.user_dto import Absent_infor
from utils.helpers.helpers import Helper
from utils.constants.message import Message
from typing_extensions import Annotated
from typing import Optional
from firebase_admin import messaging
sys.path.append("/")
router = APIRouter()

_user_service = UserService(UserRepository())

@router.patch(Urls._update_user_pass, tags=[Tags.Users.value])
async def update_user_pass(db_read: Dep._async_write_db_dep,db_write: Dep._async_write_db_dep,user_id:UUID, user_pass: Annotated[str, Form()],user_infor: dict = Depends(SecurityOauth2(roles=["public"]))):
    try:
        if uuid.UUID(str(user_infor['sub']).split(':')[-1]) == user_id:
            result = await _user_service.update_user_pass(db_read,db_write,user_id,user_pass)
            if result :
                return Helper.custom_json_response(status_code=status.HTTP_200_OK, data="",message=Message._update_user_success)
        return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message_error=Message._update_user_fail)
    except Exception:
        return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message_error=Message._server_error)

@router.get(Urls._get_me, tags=[Tags.Users.value], response_model= Optional[UserOut], status_code=status.HTTP_200_OK)
async def get_me(db: Dep._async_read_db_dep, userdata:TokenUser= Depends(SecurityOauth2(roles=["public"]))):
    result = await _user_service.get(db = db, userdata = uuid.UUID(str(userdata['sub']).split(':')[-1]))
    if result is not None:
        return Helper.custom_json_response(status_code=status.HTTP_200_OK, message=Message._success, data= jsonable_encoder(UserOut.model_validate(result)))
    return Helper.custom_json_response(status_code=status.HTTP_401_UNAUTHORIZED,message_error=Message._no_authenticate)


@router.post(Urls._create_user,status_code=status.HTTP_201_CREATED, tags=[Tags.Users.value], response_model= Optional[UserOut])
async def create(db_read: Dep._async_write_db_dep,db_write: Dep._async_write_db_dep, email: Annotated[str, Form()], username: Annotated[str, Form()], password: Annotated[str, Form()], phone : Annotated[str, Form()]):
    result = await _user_service.add_user(db_read,db_write, email, username, password, phone)
    if result is None:
        return Helper.custom_error_json_response(status_code=status.HTTP_403_FORBIDDEN,message_error=Message._user_exist)
    return result

@router.delete(Urls._delete_user,tags=[Tags.Users.value])
async def delete(db_read: Dep._async_read_db_dep,db_write: Dep._async_write_db_dep, user_infor: dict = Depends(SecurityOauth2(roles=["public"]))):
    result = await _user_service.delete(db_read,db_write,uuid.UUID(str(user_infor['sub']).split(':')[-1]))
    if result is None:
        return Helper.custom_error_json_response(status_code=status.HTTP_404_NOT_FOUND,message_error=Message._delete_user_fail)
    await RedisCaching.clear_cache("user_token:"+ user_infor['preferred_username'])
    return Helper.custom_json_response(status_code=status.HTTP_200_OK,message=Message._delete_user_success,data=None)


@router.post(Urls._create_absence_employee, tags=[Tags.Employees.value])
async def create_employee_absent(db: Dep._async_write_db_dep,absent_infor: Absent_infor):
    result = await _user_service.create_employee_absent(db = db, absent_infor = absent_infor)
    if result is None:
        return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,message_error=Message._create_error)
    return Helper.custom_json_response(status_code=status.HTTP_200_OK,data=[jsonable_encoder(result)],message=Message._success)

@router.patch(Urls._update_user, tags=[Tags.Users.value])
async def update_user(db_read: Dep._async_write_db_dep,db_write: Dep._async_write_db_dep,user_id:UUID, username: Optional[str] = Form(None),phone :Optional[str] = Form(None),firstname:Optional[str] = Form(None),lastname:Optional[str] = Form(None),user_infor: dict = Depends(SecurityOauth2(roles=["public"])),email:Optional[str] = Form(None),):
    try:
        if uuid.UUID(str(user_infor['sub']).split(':')[-1]) == user_id:
            result = await _user_service.update_user(db_read,db_write,user_id,email,phone,username,firstname,lastname)
            if result :
                return Helper.custom_json_response(status_code=status.HTTP_200_OK, data="",message=Message._update_user_success)
        return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message_error=Message._update_user_fail)
    except Exception:
        return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message_error=Message._server_error)

# @router.get("/test/pro")
# async def test1():
#     await KafkaExcecute.produce(topic="tienlab", key="beauti-app", value=json.dumps({"test":"1"}))
#     return "producer"
