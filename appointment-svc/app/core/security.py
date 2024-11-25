from fastapi import HTTPException
from fastapi.security import OAuth2AuthorizationCodeBearer
from fastapi import Security, HTTPException, status
from loguru import logger
from thirdparty.connections import KeycloakConnection
from utils.constants.message import Message
from core.enviroment_params import get_env
from thirdparty.redis.caching import RedisCaching
import json
import jwt
import sys
sys.path.append('/')
sys.tracebacklimit = 0


oauth2_scheme = OAuth2AuthorizationCodeBearer(
    authorizationUrl=f"{get_env(
    ).KEYCLOAK_URL}/realms/{get_env().KEYCLOAK_REALM_NAME}/protocol/openid-connect/auth",
    tokenUrl=f"{get_env(
    ).KEYCLOAK_URL}/realms/{get_env().KEYCLOAK_REALM_NAME}/protocol/openid-connect/token"
)


class SecurityOauth2:
    def __init__(self, roles: list):
        self.__roles = roles

    async def __call__(self, token: str = Security(oauth2_scheme)):
        try:
            username = jwt.decode(token, options={"verify_signature": False})["preferred_username"]
            cache_token = await RedisCaching.get_cache(key="user_token:"+ username)
            
            if cache_token is not None:
                cache_token = json.loads(cache_token)
                if token == cache_token['access_token']:
                    return cache_token
            logger.info("miss cache token")
            conn = await KeycloakConnection().connect()
            user_info = conn.introspect(token)
            if not user_info['active']:
                raise Exception("401")
            if not all(roles in user_info["roles"] for roles in self.__roles):
                raise Exception("403")
            logger.info("set cache token")
            user_info['access_token'] = token
            await RedisCaching.set_cache(key="user_token:"+ user_info["username"], value=json.dumps(user_info),timeout=1740)
            return user_info
        except Exception as e:
            logger.debug(e)
            if str(e) == "403":
                raise HTTPException(
                    status_code=status.HTTP_403_FORBIDDEN,
                    detail=Message._no_permission)
            else:
                raise HTTPException(
                    status_code=status.HTTP_401_UNAUTHORIZED,
                    detail=Message._no_authenticate)
