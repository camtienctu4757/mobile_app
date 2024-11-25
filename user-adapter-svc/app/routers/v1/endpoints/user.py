from utils.constants.enum import Tags
<<<<<<< HEAD
=======
<<<<<<< HEAD
from fastapi import APIRouter, status
from utils.constants.message import Message
from fastapi import status
=======
>>>>>>> camtienv7
from uuid import UUID
from fastapi import APIRouter, status, File, UploadFile, Form, Depends
from loguru import logger
from utils.constants.message import Message
from fastapi import FastAPI, Depends, HTTPException, status
<<<<<<< HEAD
=======
>>>>>>> camtienv6
>>>>>>> camtienv7
from crud.repositories.user_repository import UserRepository
from crud.services.user_service import UserService
from utils.helpers.helpers import Helper
from utils.constants.common.depends import Depend as Dep
from fastapi.encoders import jsonable_encoder
<<<<<<< HEAD
from core.security import BasicAuth
=======
<<<<<<< HEAD
=======
from core.security import BasicAuth
>>>>>>> camtienv6
>>>>>>> camtienv7
import sys

sys.path.append('/')
router = APIRouter()


_user_service = UserService(UserRepository())

@router.get("/users", tags=[Tags.Users.value])
async def get_user_all(db: Dep._async_read_db_dep):
    data = await _user_service.get_all(db=db)
    return Helper.custom_json_response(status_code=status.HTTP_200_OK, message=Message._success, data=jsonable_encoder(data))

@router.get("/users/find_by_username", tags=[Tags.Users.value])
async def get_user_username(username: str,db: Dep._async_read_db_dep):
    data = await  _user_service.get_by_username(username=username,db=db)
    return Helper.custom_json_response(status_code=status.HTTP_200_OK, message=Message._success, data=jsonable_encoder(data))


@router.get("/users/find_by_id", tags=[Tags.Users.value], )
async def get_user_username(user_id: str,db: Dep._async_read_db_dep):
    data = await _user_service.get_user_byid(user_id=user_id, db = db)
    return Helper.custom_json_response(status_code=status.HTTP_200_OK, message=Message._success, data=jsonable_encoder(data))

@router.get("/users/find_by_email", tags=[Tags.Users.value])
async def get_user_email(email: str,db: Dep._async_read_db_dep):
    data = await _user_service.get_by_email(db = db, email=email)
    return Helper.custom_json_response(status_code=status.HTTP_200_OK, message=Message._success, data=jsonable_encoder(data))

@router.get("/users/count", tags=[Tags.Users.value])
async def count_user(db: Dep._async_read_db_dep):
    data = await _user_service.count_user(db = db)
    return Helper.custom_json_response(status_code=status.HTTP_200_OK, message=Message._success, data=jsonable_encoder(data))

@router.get("/users/search", tags=[Tags.Users.value])
async def search_user(words: str, db: Dep._async_read_db_dep):
    data = await _user_service.get_all(db=db)
    return Helper.custom_json_response(status_code=status.HTTP_200_OK, message=Message._success, data=jsonable_encoder(data))