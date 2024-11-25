from utils.constants.enum import Tags
from uuid import UUID
from fastapi import APIRouter, status, File, UploadFile, Form, Depends
from loguru import logger
from utils.constants.message import Message
from fastapi.security import HTTPBasic, HTTPBasicCredentials
from fastapi import FastAPI, Depends, HTTPException, status
from crud.repositories.user_repository import UserRepository
from crud.services.user_service import UserService
from utils.helpers.helpers import Helper
from utils.constants.common.depends import Depend as Dep
from fastapi.encoders import jsonable_encoder
import json
import sys
import secrets
from core.enviroment_params import get_env
sys.path.append('/')
sys.tracebacklimit = 0

class BasicAuth():
    __security = HTTPBasic()
    __username: str = get_env().AUTH_BASIC_USERNAME
    __password: str = get_env().AUTH_BASIC_PASSWORD
    def authenticate(self, credentials: HTTPBasicCredentials = Depends(__security)):
        correct_username = secrets.compare_digest(credentials.username, self.__username)
        correct_password = secrets.compare_digest(credentials.password, self.__password)

        if not (correct_username and correct_password):
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Incorrect username or password",
                headers={"WWW-Authenticate": "Basic"},
            )
        return credentials.username