from keycloak import KeycloakOpenID
from loguru import logger
from core.enviroment_params import get_env
from utils.helpers.singleton import SingletonMeta
import sys
sys.path.append('/')
sys.tracebacklimit = 0

class Oauth2Keycloak(metaclass=SingletonMeta):
    __keycloak_url: str = get_env().KEYCLOAK_URL
    __keycloak_realm_name: str = get_env().KEYCLOAK_REALM_NAME
    __keycloak_client_id: str = get_env().KEYCLOAK_CLIENT_ID
    __keycloak_client_secret: str = get_env().KEYCLOAK_CLIENT_SECRET

    def __init__(self):
        self.connection: KeycloakOpenID = None

    def create_connection(self) -> KeycloakOpenID:
        try:
            if self.connection is None:
                self.connection = KeycloakOpenID(
                    server_url=self.__keycloak_url,
                    realm_name=self.__keycloak_realm_name,
                    client_id=self.__keycloak_client_id,
                    client_secret_key=self.__keycloak_client_secret,
                    verify=True,
                    timeout=30
                )
            return self.connection
        except Exception as e:
            logger.error(f"Failed to create keycloak connection: {e}")
            sys.exit(1)

    def get_connection(self) -> KeycloakOpenID:
        return self.create_connection()
