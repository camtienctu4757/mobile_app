import sys
from abc import ABC, abstractmethod
from sqlalchemy.ext.asyncio import AsyncSession
from redis.asyncio.cluster import RedisCluster
from redis.asyncio import Redis
from typing import AsyncGenerator
from thirdparty.db.sessions import PostgresDBManager
from thirdparty.redis.sessions import RedisManager
from thirdparty.keycloak.sessions import Oauth2Keycloak
from thirdparty.kafka.sessions import KafkaProducer,KafkaConsumer
from confluent_kafka import Producer,Consumer,KafkaError,KafkaException
from keycloak import KeycloakOpenID
from minio import Minio
from sqlalchemy import text
from loguru import logger
sys.path.append('/')
sys.tracebacklimit = 0


class ThirdpartyConnections(ABC):

    @abstractmethod
    async def connect(self):
        pass

    @abstractmethod
    def check_status(self):
        pass

    @abstractmethod
    def disconnect(self):
        pass


class PostgresConnection(ThirdpartyConnections):
    # Using wrapper function for  the depend injection
    @classmethod
    def connect(self, db_type: str) -> AsyncGenerator[AsyncSession, None]:
        try:
            if db_type == "read":
                async def get_read_connect() -> AsyncGenerator[AsyncSession, None]:
                    async with PostgresDBManager().get_session(db_type=db_type) as db:
                        yield db
                return get_read_connect
            elif db_type == "write":
                async def get_write_connect() -> AsyncGenerator[AsyncSession, None]:
                    async with PostgresDBManager().get_session(db_type=db_type) as db:
                        yield db
                return get_write_connect
            else:
                raise Exception(f"There is not type db: {db_type} ")
        except Exception as e:
            logger.error(f"Failed to connect to Postgres: {e}")
            sys.exit(1)
    @classmethod
    async def connect1(self, db_type: str):
        try:
            if db_type == "read":
                async with PostgresDBManager().get_session(db_type=db_type) as db:
                    return db
            elif db_type == "write":
                async with PostgresDBManager().get_session(db_type=db_type) as db:
                    return db
            else:
                raise Exception(f"There is not type db: {db_type} ")
        except Exception as e:
            logger.error(f"Failed to connect to Postgres: {e}")
            sys.exit(1)

    @classmethod
    async def check_status(self) -> None:
        try:
            async with PostgresDBManager().get_session(db_type="read") as read_db:
                await read_db.execute(text("SELECT 1"))
            async with PostgresDBManager().get_session(db_type="write") as write_db:
                await write_db.execute(text("SELECT 1"))
        except Exception as e:
            logger.error(f"Failed to check status Postgres: {e}")
            sys.exit(1)

    @classmethod
    async def disconnect(self) -> None:
        await PostgresDBManager().disconnect_engine()


class RedisConnection(ThirdpartyConnections):
    @classmethod
    async def connect(self) -> Redis | RedisCluster:
        try:
            async with RedisManager().get_connection() as conn:
                return conn
        except Exception as e:
            logger.error(f"Failed to connect to Redis: {e}")
            sys.exit(1)

    @classmethod
    async def check_status(self) -> None:
        try:
            async with RedisManager().get_connection() as conn:
                await conn.ping()
        except Exception as e:
            logger.error(f"Failed to check status Redis: {e}")
            sys.exit(1)

    @classmethod
    async def disconnect(self) -> None:
        await RedisManager().close_connection()

    @classmethod
    async def set_job_delete_idle_connection(self) -> None:
        await RedisManager().set_job_delete_idle_connection()


class MinioConnection(ThirdpartyConnections):
    @classmethod
    async def connect(self) -> Minio:
        pass

    @classmethod
    async def check_status(self)-> None:
       pass

    # Minio auto close connections of client after request is completed
    @classmethod
    async def disconnect(self):
        pass


class KeycloakConnection(ThirdpartyConnections):
    @classmethod
    async def connect(self) -> KeycloakOpenID:
        try:
            return Oauth2Keycloak().get_connection()
        except Exception as e:
            logger.error(f"Failed to connect to Keycloak: {e}")
            sys.exit(1)

    @classmethod
    async def check_status(self) -> None:
        try:
            conn = Oauth2Keycloak().get_connection()
            conn.well_known()
        except Exception as e:
            logger.error(f"Failed to check status Keycloak: {e}")
            sys.exit(1)

    # Minio auto close connections of client after request is completed
    @classmethod
    async def disconnect(self):
        pass

class KafkaProducerConnection(ThirdpartyConnections):

    @classmethod
    async def connect(self) -> Producer:
        try:
            return KafkaProducer().get_connection()
        except Exception as e:
            logger.error(f"Failed to connect to kafka: {e}")
            sys.exit(1)

    @classmethod
    async def check_status(self):
        try:
            producer =  KafkaProducer().get_connection()
            producer.produce("healthcheck", key="check", value="ping",callback=
                            lambda err, msg: logger.error(f"The kafka message delivery failed: {err}") if err is not None else None)
            producer.flush()
        except Exception as e:
            logger.error(f"Failed to check status kafka producers: {e}")
            sys.exit(1)
class KafkaConsumerConnection(ThirdpartyConnections):
    __group_id = None
    def __init__(self, group_id: str):
        self.__group_id = group_id   
         
    def connect(self) -> Consumer:
        try:
            return KafkaConsumer(group_id=self.__group_id).get_connection()
        except Exception as e:
            logger.error(f"Failed to connect to kafka: {e}")
            sys.exit(1)
            
    @classmethod
    def check_status(self):
        try:
            consumer = KafkaConsumer(group_id='healthcheck').get_connection()
            consumer.subscribe(["healthcheck"])
            msg = consumer.poll(timeout=1.0)
            if msg is not None:
                if msg.error():
                    logger.error(f"Failed to check status kafka consumers: {e}")
                    sys.exit(1)
                else:
                    consumer.commit(asynchronous=True)
        except Exception as e:
            logger.error(f"Failed to check status kafka consumers: {e}")
            sys.exit(1)
        finally:
            consumer.close()
    
    @classmethod
    async def disconnect(self):
        pass
