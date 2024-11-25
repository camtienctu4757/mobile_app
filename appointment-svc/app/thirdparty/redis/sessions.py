from redis.asyncio.cluster import RedisCluster, ClusterNode
from redis.asyncio import Redis
from redis.asyncio.retry import Retry
from redis.exceptions import (
    TimeoutError,
    ConnectionError,
    ClusterError,
    ClusterDownError,
    RedisClusterException,
    ClusterCrossSlotError,
)
from redis.backoff import ExponentialBackoff
from contextlib import asynccontextmanager
from core.enviroment_params import get_env
from loguru import logger
import ast
from utils.helpers.helpers import Helper
import sys
from typing import AsyncGenerator
from utils.helpers.schedulers import Scheduler
from apscheduler.triggers.interval import IntervalTrigger
from utils.helpers.singleton import SingletonMeta

sys.path.append("/")
sys.tracebacklimit = 0

class RedisManager(metaclass=SingletonMeta):
    __max_pool_size: int = int(get_env().REDIS_MAX_POOL_SIZE)
    __redis_clientname: str = get_env().REDIS_CLIENTNAME
    __redis_host: str = get_env().REDIS_HOST
    __redis_port: int = int(get_env().REDIS_PORT)
    __redis_username: str = get_env().REDIS_USERNAME
    __redis_password: str = get_env().REDIS_PASSWORD
    __redis_db: str = int(get_env().REDIS_DB)
    __redis_ssl: bool = Helper.str_to_bool(get_env().REDIS_SSL)
    __redis_ca_file: str = get_env().REDIS_CA_FILE
    __redis_cert_file: str = get_env().REDIS_CERT_FILE
    __redis_key_file: str = get_env().REDIS_KEY_FILE
    __redis_method: str = get_env().REDIS_CONN_METHOD
    __redis_pool_timeout: int = int(get_env().REDIS_POOL_TIMEOUT)
    __redis_pool_drop_job_interval: int = int(get_env().REDIS_POOL_DROP_JOB_INTERVAL)

    __startup_nodes: list = [
        ClusterNode(i["host"], int(i["port"]))
        for i in ast.literal_eval(get_env().REDIS_CLUSTER_HOSTS)
    ]
    __retry: Retry = Retry(
        ExponentialBackoff(cap=5, base=1), int(get_env().REDIS_RETRY)
    )

    def __init__(self):
        self.connection: Redis | RedisCluster = None

    async def create_connection(self) -> Redis | RedisCluster:
        try:
            if self.connection is None:
                if self.__redis_method == "standalone":
                    self.connection = await Redis(
                        host=self.__redis_host,
                        port=self.__redis_port,
                        username=self.__redis_username,
                        password=self.__redis_password,
                        db=self.__redis_db,
                        client_name=self.__redis_clientname,
                        encoding="utf-8",
                        decode_responses=True,
                        max_connections=self.__max_pool_size,
                        retry_on_timeout=True,
                        retry=self.__retry,
                        retry_on_error=[
                            ConnectionError,
                            TimeoutError,
                            ConnectionResetError,
                        ],
                        socket_connect_timeout=10,
                        socket_timeout=10,
                        ssl=self.__redis_ssl,
                        ssl_cert_reqs="required",
                        ssl_ca_certs=self.__redis_ca_file,
                        ssl_certfile=self.__redis_cert_file,
                        ssl_keyfile=self.__redis_key_file,
                    )
                elif self.__redis_method == "cluster":
                    self.connection = await RedisCluster(
                        startup_nodes=self.__startup_nodes,
                        username=self.__redis_username,
                        password=self.__redis_password,
                        db=self.__redis_db,
                        client_name=self.__redis_clientname,
                        read_from_replicas=True,
                        encoding="utf-8",
                        decode_responses=True,
                        max_connections=self.__max_pool_size,
                        retry=self.__retry,
                        retry_on_error=[
                            ClusterCrossSlotError,
                            ConnectionError,
                            TimeoutError,
                            ConnectionResetError,
                            ClusterError,
                            ClusterDownError,
                        ],
                        socket_connect_timeout=10,
                        socket_timeout=10,
                        ssl=self.__redis_ssl,
                        ssl_cert_reqs="required",
                        ssl_ca_certs=self.__redis_ca_file,
                        ssl_certfile=self.__redis_cert_file,
                        ssl_keyfile=self.__redis_key_file,
                    )
                else:
                    raise Exception(
                        f"There is not the connect method: {self.__redis_method}"
                    )
            return self.connection
        except Exception as e:
            logger.error(f"Failed to create redis connection: {e}")
            sys.exit(1)

    @asynccontextmanager
    async def get_connection(self) -> AsyncGenerator[Redis | RedisCluster, any]:
        """
        Don't close connection
        """
        conn = await self.create_connection()
        try:
            yield conn
        finally:
            pass

    async def close_connection(self):
        try:
            if self.connection is not None:
                await self.connection.close()
        except Exception as e:
            logger.error(f"Failed to close the Redis connection: {e}")
            sys.exit(1)

    @Helper.measure_time()
    async def delete_idle_connection(self) -> None:
        try:
            async with self.get_connection() as conn:
                if self.__redis_method == "standalone":
                    clients = await conn.client_list()
                    for i in clients:
                        if int(i["idle"]) > self.__redis_pool_timeout and i["name"] == self.__redis_clientname and i["user"] == self.__redis_username:
                            await conn.execute_command('CLIENT KILL', 'ID', int(i["id"]))
                    logger.info(f"Idle connections was disconnected")
                elif self.__redis_method == "cluster":
                    nodes = [i["host"] for i in ast.literal_eval(get_env().REDIS_CLUSTER_HOSTS)]                
                    for node in nodes:
                        conn = await Redis(host=node, port=6379,
                                                username=self.__redis_username,
                                                password=self.__redis_password,
                                                db=self.__redis_db,
                                                encoding="utf-8",
                                                decode_responses=True,
                                                socket_connect_timeout=10,
                                                socket_timeout=10,
                                                retry=self.__retry,
                                                retry_on_error=[ConnectionError, TimeoutError, ConnectionResetError],
                                                ssl=self.__redis_ssl,
                                                ssl_cert_reqs='required',
                                                ssl_ca_certs=self.__redis_ca_file,
                                                ssl_certfile=self.__redis_cert_file,
                                                ssl_keyfile=self.__redis_key_file)
                        clients = await conn.client_list()
                        for i in clients:
                            if int(i["idle"]) > self.__redis_pool_timeout and i["name"] == self.__redis_clientname and i["user"] == self.__redis_username:
                                await conn.execute_command('CLIENT KILL', 'ID', int(i["id"]))
                        await conn.close()
                    logger.info(f"Idle connections was disconnected")
        except Exception as e:
            logger.error(f"Failed to close the idle Redis connection: {e}")

    async def set_job_delete_idle_connection(self) -> None:
        try:
            Scheduler().add_async_job(
                job=self.delete_idle_connection,
                trigger=IntervalTrigger(seconds=self.__redis_pool_drop_job_interval),
            )
        except Exception as e:
            logger.error(f"Failed to close the idle Redis connection: {e}")
