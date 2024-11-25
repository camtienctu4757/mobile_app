from utils.constants.enum import Tags
from utils.constants.urls import Urls
from fastapi.encoders import jsonable_encoder
from fastapi import APIRouter, status,Form,Depends,Query
from typing_extensions import Annotated
from utils.constants.common.depends import Depend
from crud.services.product_service import ProductService
from crud.repositories.product_repository import ProductRepository
from schemas.respones.product_dto import ProductOut as response_product
from schemas.respones.product_dto import ServiceWithImages
from typing import List
import uuid
from uuid import UUID
from utils.constants.message import Message
from utils.helpers.helpers import Helper
from thirdparty.redis.caching import RedisCaching
from thirdparty.db.models.services import Service
from core.security import SecurityOauth2
import sys
sys.path.append('/')
router = APIRouter()

_product_service = ProductService(ProductRepository())

@router.get(Urls._get_all_product,response_model=List[ServiceWithImages] ,tags=[Tags.Products.value])
async def get_product_all(db: Depend._async_read_db_dep):
    try:
        result = await _product_service.get_all(db=db)
        return Helper.custom_json_response(status_code=status.HTTP_200_OK, data=jsonable_encoder(result), message=Message._success)
    except Exception:
        return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message_error=Message._server_error)

@router.get(Urls._get_product_catalog, tags=[Tags.Products.value], response_model= List[response_product])
@RedisCaching.api_caching(prefix="product", suffix=["catalog_name"], is_setcache=True, timeout=1000)
async def get_product_catalog(db: Depend._async_read_db_dep,catalog_name:str):
    try:
        data = await _product_service.get_bycatalog(catalog_name= catalog_name, db=db)
        if not data:
            return Helper.custom_error_json_response(status_code=status.HTTP_404_NOT_FOUND, message_error=Message._no_content)
        return Helper.custom_json_response(status_code=status.HTTP_200_OK, data=jsonable_encoder(data), message=Message._success)
    except Exception as e:
        print(f"error: {e}")
        return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message_error=Message._server_error)

@router.get(Urls._search_products,response_model=List[ServiceWithImages] ,tags=[Tags.Products.value])
async def search_product(db: Depend._async_read_db_dep, query: str = Query(..., min_length=1)
):
    try:
        result = await _product_service.search(db=db,query = query)
        return Helper.custom_json_response(status_code=status.HTTP_200_OK, data=jsonable_encoder(result), message=Message._success)
    except Exception:
        return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message_error=Message._server_error)
    
@router.get(Urls._get_product_shopid, tags=[Tags.Products.value],response_model= List[response_product])
@RedisCaching.api_caching(prefix="product", suffix=["shop_id"], is_setcache=True, timeout=1000)
async def get_product_shop(db: Depend._async_read_db_dep, shop_id :UUID):
    try:
        data = await _product_service.get_byshop(shop_id= shop_id, db=db)
        if not data:
            return Helper.custom_error_json_response(status_code=status.HTTP_404_NOT_FOUND, message_error=Message._no_content)
        return Helper.custom_json_response(status_code=status.HTTP_200_OK, data=jsonable_encoder(data), message=Message._success)
    except Exception:
        return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message_error=Message._server_error)


@router.get(Urls._get_product_id, tags=[Tags.Products.value], status_code=status.HTTP_200_OK,response_model= response_product)
@RedisCaching.api_caching(prefix="product", suffix=["product_id"], is_setcache=True, timeout=1000)
async def get_product_id(product_id: UUID, db: Depend._async_read_db_dep):
    try:
        data = await _product_service.get_product(product_id=product_id, db=db)
        if not data:
            return Helper.custom_error_json_response(status_code=status.HTTP_404_NOT_FOUND, message_error=Message._no_content)
        return Helper.custom_json_response(status_code=status.HTTP_200_OK, data=jsonable_encoder(data), message=Message._success)
    except Exception:
        return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message_error=Message._server_error)


@router.post(Urls._add_product, tags=[Tags.Products.value], status_code=status.HTTP_201_CREATED)
async def add_product(db: Depend._async_write_db_dep,
    name: Annotated[str, Form()],
    description: Annotated[str, Form()],
    style: Annotated[str, Form()],
    price: Annotated[int, Form()],
    shop_id: Annotated[str, Form()],
    duration: Annotated[float, Form()],
    employee: Annotated[int, Form()],
    user_infor: dict = Depends(SecurityOauth2(roles=["shop"]))
    ):
    try:
        newService = Service(service_name = name, description = description, price = price, shop_uuid = shop_id, duration= duration,employees=employee)
        result = await _product_service.add_product(db=db,product=newService,style=style,owner_id = uuid.UUID(str(user_infor['sub']).split(':')[-1]))
        if not result:
            return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message_error=Message._no_content)
        return Helper.custom_json_response(status_code=status.HTTP_201_CREATED, data=jsonable_encoder(result), message=Message._success)
    except Exception as e:
        price(e)
        return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message_error=Message._server_error)


@router.delete(Urls._delete_product, tags=[Tags.Products.value], status_code= status.HTTP_200_OK)
async def delete_product(db_read:Depend._async_read_db_dep,db_write: Depend._async_write_db_dep, product_id,user_infor: dict = Depends(SecurityOauth2(roles=["shop"]))):
    try:
        result = await _product_service.delete(db_read = db_read,db_write = db_write, product_id = product_id, user_id = uuid.UUID(str(user_infor['sub']).split(':')[-1]))
        if result == True :
            RedisCaching.clear_cache(key="product"+str(product_id))
            return Helper.custom_json_response(status_code=status.HTTP_200_OK, data={}, message= Message._success)
    except Exception:
        return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message_error=Message._server_error)

@router.put(Urls._update_product, tags=[Tags.Products.value], status_code= status.HTTP_200_OK)
async def update_product(
    servicer_id:Annotated[str, Form()],
    db_write: Depend._async_write_db_dep,
    db_read: Depend._async_read_db_dep,
    name: Annotated[str, Form()],
    description: Annotated[str, Form()],
    catalog_id: Annotated[str, Form()],
    price: Annotated[int, Form()],
    shop_id: Annotated[str, Form()],
    duration: Annotated[float, Form()],
    employee: Annotated[int, Form()],
    user_infor: dict = Depends(SecurityOauth2(roles=["shop"]))
    ):
    try:
        result = await _product_service.update(db_read=db_read,db_write= db_write,servicer_id = servicer_id, name = name, description = description, price = price, shop_id = shop_id,duration = duration, employee = employee, owner = uuid.UUID(str(user_infor['sub']).split(':')[-1]))
        if result == True:
            return Helper.custom_json_response(status_code=status.HTTP_200_OK, data="", message= Message._success)
        return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message_error=Message._error)
    except Exception as e:
        return Helper.custom_error_json_response(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, message_error=Message._server_error)

@router.get("/test/redis_delete_cache", tags=[Tags.Products.value])
async def read_items():
    await RedisCaching.clear_cache(key="productfa9121a6-9633-40d0-8a55-4b6f076fb5e9")
    return "ok"
