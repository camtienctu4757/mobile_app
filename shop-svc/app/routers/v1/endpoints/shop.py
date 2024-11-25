from utils.constants.enum import Tags
from utils.constants.urls import Urls
from typing_extensions import Annotated
from fastapi.encoders import jsonable_encoder
from fastapi import APIRouter, status, Form, Depends,HTTPException
from utils.constants.common.depends import Depend
from crud.services.shop_service import ShopService
from crud.repositories.shop_repository import ShopRepository
from schemas.respones.shop_dto import shopout
from schemas.requests.shop_dto import ShopUpdate
from typing import List
from uuid import UUID
from utils.constants.message import Message
from loguru import logger
from utils.helpers.helpers import Helper
from thirdparty.redis.caching import RedisCaching
from thirdparty.db.models.shops import Shop
from datetime import time
from core.security import SecurityOauth2
import uuid
import sys

sys.path.append("/")
router = APIRouter()

_shop_service = ShopService(ShopRepository())

@router.get(
    Urls._get_shopby_userid, response_model=list[shopout], tags=[Tags.Shops.value]
)
async def get_shopby_userid(db: Depend._async_read_db_dep,user_infor: dict = Depends(SecurityOauth2(roles=["shop"]))):
    try:
        result =  await _shop_service.get_shopby_userid(db=db, owner_id=uuid.UUID(str(user_infor['sub']).split(':')[-1]))
        data = [shopout.model_validate(shop) for shop in result]
        if not data:
            return Helper.custom_error_json_response(status_code=status.HTTP_404_NOT_FOUND, message_error=Message._no_content)
        return Helper.custom_json_response(status_code=status.HTTP_200_OK, data=jsonable_encoder(data), message= Message._success)
    except Exception as e:
        logger.error(f"{e}")
        return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message_error=Message._server_error)

# @router.get(
#     Urls._get_nearby_shop, response_model=list[shopout], tags=[Tags.Shops.value],dependencies=[Depends(SecurityOauth2(roles=["shop"]))]
# )
# @RedisCaching.api_caching(prefix="shop", suffix=["lat","long"], is_setcache=True, timeout=1000)
# async def get_nearby_shop(db: Depend._async_read_db_dep, lat: float, long: float):
#     try:
#         result = await _shop_service.get_nearby_shop(db=db,lat = lat, long = long)
#         data = [shopout.model_validate(shop) for shop in result]
#         if not data:
#             return Helper.custom_error_json_response(status_code=status.HTTP_404_NOT_FOUND, message_error=Message._no_content)
#         return Helper.custom_json_response(status_code=status.HTTP_200_OK, data=jsonable_encoder(data), message= Message._success)
#     except Exception as e:
#         logger.error(f"{e}")
#         return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message_error=Message._server_error)

@router.get(Urls._get_shop_id, response_model=shopout, tags=[Tags.Shops.value],dependencies=[Depends(SecurityOauth2(roles=["shop"]))])
@RedisCaching.api_caching(prefix="shop", suffix=["shop_id"], is_setcache=True, timeout=1000)
async def get_shop_id(db: Depend._async_read_db_dep, shop_id: UUID):
    try:
        result = await _shop_service.get(db=db, shop_id=shop_id)
        if result is None:
            return Helper.custom_error_json_response(status_code=status.HTTP_404_NOT_FOUND, message_error=Message._no_content)
        data = shopout.model_validate(result)
        return Helper.custom_json_response(status_code=status.HTTP_200_OK, data=jsonable_encoder(data), message= Message._success)
    except Exception as e:
        logger.error(f"{e}")
        return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message_error=Message._server_error)
    
@router.get("/test/redis_delete_cache", tags=[Tags.Shops.value])
async def read_items():
    await RedisCaching.clear_cache(key="user_token:ngoclan")
    return "ok"

@router.post(Urls._create_shop,tags=[Tags.Shops.value],)
async def create_shop(
    db: Depend._async_write_db_dep,
    shop_name: Annotated[str, Form()],
    address: Annotated[str, Form()],
    phone: Annotated[str, Form()],
    email: Annotated[str, Form()],
    open: Annotated[str, Form()],
    close: Annotated[str, Form()],
    user_infor: dict = Depends(SecurityOauth2(roles=["public"]))
    ):
    try: 
        open_time = time.fromisoformat(open)
        close_time = time.fromisoformat(close)
        newShop = Shop(shop_name=shop_name, address=address, phone=phone, email=email,owner_id = uuid.UUID(str(user_infor['sub']).split(':')[-1]), close_time = close_time, open_time = open_time)
        result = await _shop_service.create_shop(db=db,shop= newShop,user_id = uuid.UUID(str(user_infor['sub']).split(':')[-1]))
        if not result:
            return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message_error=Message._no_content)
        return Helper.custom_json_response(status_code=status.HTTP_201_CREATED, data=jsonable_encoder(result), message=Message._success)
    except Exception as e:
        logger.exception(e)
        return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message_error=Message._server_error)

@router.delete(
    Urls._delete_shop, tags=[Tags.Shops.value]
)
async def delete_shop(db: Depend._async_write_db_dep, shop_id: UUID,user_infor: dict = Depends(SecurityOauth2(roles=["shop"]))):
    try:
        result = await _shop_service.delete_shop(db=db,shop_id=shop_id,user_id=uuid.UUID(str(user_infor['sub']).split(':')[-1]))
        if result:
            await RedisCaching.clear_cache(key="shop" + str(shop_id))
            return HTTPException(status_code= status.HTTP_204_NO_CONTENT,detail=Message._success)
        return  Helper.custom_error_json_response(status_code=status.HTTP_404_NOT_FOUND, message_error=Message._delete_shop_fail)
    except Exception as e:
        logger.exception(e)
        return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message_error=Message._server_error)

@router.patch(Urls._update_shop, tags=[Tags.Shops.value])
async def update_shop(db: Depend._async_write_db_dep,shop_info:ShopUpdate, user_infor: dict = Depends(SecurityOauth2(roles=["shop"]))):
    try:
        result = await _shop_service.update_shop(db=db,shop_info= shop_info,user_id=uuid.UUID(str(user_infor['sub']).split(':')[-1]))
        if result:
            await RedisCaching.clear_cache(key="shop" + str(shop_info.shop_uuid))
            return Helper.custom_json_response(status_code= status.HTTP_200_OK,message=Message._success,data=jsonable_encoder(result))
        return  Helper.custom_error_json_response(status_code=status.HTTP_404_NOT_FOUND, message_error=Message._update_fail)
    except Exception as e:
        logger.exception(e)
        return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message_error=Message._server_error)
