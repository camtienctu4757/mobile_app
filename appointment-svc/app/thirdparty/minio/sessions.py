from minio import Minio
from contextlib import asynccontextmanager
import urllib3
import urllib3.util
from core.enviroment_params import get_env
from loguru import logger
from utils.helpers.helpers import Helper
from utils.helpers.singleton import SingletonMeta
import ssl
import sys
sys.path.append('/')
sys.tracebacklimit = 0

class MinioManager(metaclass=SingletonMeta):
    __minio_url: str = get_env().MINIO_URL
    __minio_username: str = get_env().MINIO_USERNAME
    __minio_password: str = get_env().MINIO_PASWORD
    __minio_ssl: bool = Helper.str_to_bool(get_env().MINIO_SSL)
    _minio_bucket_name: str = get_env().MINIO_BUCKET
    __minio_ca_file: str = get_env().MINIO_CA_FILE
    __minio_cert_file: str = get_env().MINIO_CERT_FILE
    __minio_key_file: str = get_env().MINIO_KEY_FILE
    __minio_pool_size: int = int(get_env().MINIO_POOL_SIZE)
    __minio_max_connection_per_pool: int = int(
        get_env().MINIO_MAX_CONN_PER_POOL)
    __minio_client_retry: int = int(
        get_env().MINIO_CLIENT_RETRY)

    def __init__(self):
        self.connection: Minio = None

    def create_connection(self) -> Minio:
        try:
            if self.connection is None:
                self.connection = Minio(
                    self.__minio_url,
                    access_key=self.__minio_username,
                    secret_key=self.__minio_password,
                    secure=self.__minio_ssl,
                    http_client=self.get_http_client())
            return self.connection
        except Exception as e:
            logger.error(f"Failed to create Minio connection: {e}")
            sys.exit(1)

    def get_connection(self) -> Minio:
        return self.create_connection()

    def get_http_client(self) -> urllib3.PoolManager:
        try:
            if self.__minio_ssl is True:
                ssl_context = ssl.create_default_context()
                ssl_context.verify_mode = ssl.CERT_REQUIRED
                ssl_context.load_cert_chain(
                    certfile=self.__minio_cert_file, keyfile=self.__minio_key_file)
                ssl_context.load_verify_locations(
                    cafile=self.__minio_ca_file)
                retry_strategy = urllib3.util.retry.Retry(
                    total=self.__minio_client_retry,
                    backoff_factor=1,
                    status_forcelist=[500, 502, 503, 504],
                    allowed_methods=["GET", "POST", "PUT"]
                )
                return urllib3.PoolManager(ssl_context=ssl_context, retries=retry_strategy, num_pools=self.__minio_pool_size, maxsize=self.__minio_max_connection_per_pool)
        except Exception as e:
            logger.error(f"Failed to get http client: {e}")
            sys.exit(1)
