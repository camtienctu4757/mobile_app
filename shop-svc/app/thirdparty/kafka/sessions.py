from loguru import logger
from core.enviroment_params import get_env
from utils.helpers.singleton import SingletonMeta
from confluent_kafka import Producer,Consumer,KafkaError,KafkaException
import socket
from utils.helpers.helpers import Helper
import sys
sys.path.append('/')
sys.tracebacklimit = 0

class KafkaProducer(metaclass=SingletonMeta):
    __kafka_bootstrap_servers: str = get_env().KAFKA_BOOTSTRAP_SERVERS
    __kafka_security_protocol: str = get_env().KAFKA_SECURITY_PROTOCOL
    __kafka_sasl_mechanism: str = get_env().KAFKA_SASL_MECHANISM
    __kafka_sasl_username: str = get_env().KAFKA_SASL_USERNAME
    __kafka_sasl_password: str = get_env().KAFKA_SASL_PASSWORD
    __kafka_ca_file: str = get_env().KAFKA_CA_FILE
    __kafka_cert_file: str = get_env().KAFKA_CERT_FILE
    __kafka_key_file: str = get_env().KAFKA_KEYFILE
    __kafka_log_level: int = int(get_env().KAFKA_LOG_LEVEL)
    __kafka_acks: str = get_env().KAFKA_ACKS 
    __kafka_socket_keepalive: bool = Helper.str_to_bool(get_env().KAFKA_SOCKET_KEEPALIVE) 
    __kafka_conn_max_idle_ms: int = int(get_env().KAFKA_CONN_MAX_IDLE_MS)  
    __kafka_retry: int = int(get_env().KAFKA_RETRY)
    __kafka_retry_backoff_ms: int = int(get_env().KAFKA_RETRY_BACKOFF_MS)
    __kafka_request_timeout_ms: int = int(get_env().KAFKA_REQUEST_TIMEOUT_MS)
    __kafka_delivery_timeout_ms: int = int(get_env().KAFKA_DELIVERY_TIMEOUT_MS)
    __kafka_message_timeout_ms: int = int(get_env().KAFKA_MESSAGE_TIMEOUT_MS)
    __kafka_idempotence: bool = Helper.str_to_bool(get_env().KAFKA_IDEMPOTENCE)
    __kafka_compression_type: str = get_env().KAFKA_COMPRESSION_TYPE
    __kafka_linger_ms: str = get_env().KAFKA_LINGER_MS
    __kafka_message_max_bytes: str = get_env().KAFKA_MESSAGE_MAX_BYTES                     
    def __init__(self):
        self.producer: Producer = None

    def create_connection(self) -> Producer:
        proconf = {'bootstrap.servers': self.__kafka_bootstrap_servers,
        'security.protocol': self.__kafka_security_protocol,
        'sasl.mechanism': self.__kafka_sasl_mechanism,
        'sasl.username':  self.__kafka_sasl_username,
        'sasl.password': self.__kafka_sasl_password,
        'ssl.ca.location': self.__kafka_ca_file,
        'ssl.certificate.location': self.__kafka_cert_file,
        'ssl.key.location': self.__kafka_key_file, 
        'acks': self.__kafka_acks,
        'request.timeout.ms' : self.__kafka_request_timeout_ms,
        'delivery.timeout.ms' : self.__kafka_delivery_timeout_ms,
        'message.timeout.ms' : self.__kafka_message_timeout_ms,
        'retries': self.__kafka_retry,
        'enable.idempotence': self.__kafka_idempotence,
        'connections.max.idle.ms': self.__kafka_conn_max_idle_ms,
        'retry.backoff.ms': self.__kafka_retry_backoff_ms,
        'socket.keepalive.enable': self.__kafka_socket_keepalive, 
        'compression.type': self.__kafka_compression_type,
        'linger.ms': self.__kafka_linger_ms,
        'message.max.bytes': self.__kafka_message_max_bytes,
        'log_level': self.__kafka_log_level,
        'client.id': socket.gethostname()}
        try:
            if self.producer is None:
                self.producer = Producer(proconf)
            return self.producer
        except Exception as e:
            logger.error(f"Failed to create producer kafka connection: {e}")
            sys.exit(1)

    def get_connection(self) -> Producer:
        return self.create_connection()

class KafkaConsumer():
    __kafka_bootstrap_servers: str = get_env().KAFKA_BOOTSTRAP_SERVERS
    __kafka_security_protocol: str = get_env().KAFKA_SECURITY_PROTOCOL
    __kafka_sasl_mechanism: str = get_env().KAFKA_SASL_MECHANISM
    __kafka_sasl_username: str = get_env().KAFKA_SASL_USERNAME
    __kafka_sasl_password: str = get_env().KAFKA_SASL_PASSWORD
    __kafka_ca_file: str = get_env().KAFKA_CA_FILE
    __kafka_cert_file: str = get_env().KAFKA_CERT_FILE
    __kafka_key_file: str = get_env().KAFKA_KEYFILE
    __kafka_log_level: int = int(get_env().KAFKA_LOG_LEVEL)
    __kafka_acks: str = get_env().KAFKA_ACKS 
    __kafka_socket_keepalive: bool = Helper.str_to_bool(get_env().KAFKA_SOCKET_KEEPALIVE) 
    __kafka_conn_max_idle_ms: int = int(get_env().KAFKA_CONN_MAX_IDLE_MS)  
    __kafka_retry: int = int(get_env().KAFKA_RETRY)
    __kafka_retry_backoff_ms: int = int(get_env().KAFKA_RETRY_BACKOFF_MS)
    __kafka_request_timeout_ms: int = int(get_env().KAFKA_REQUEST_TIMEOUT_MS)
    __kafka_delivery_timeout_ms: int = int(get_env().KAFKA_DELIVERY_TIMEOUT_MS)
    __kafka_message_timeout_ms: int = int(get_env().KAFKA_MESSAGE_TIMEOUT_MS)
    __kafka_idempotence: bool = Helper.str_to_bool(get_env().KAFKA_IDEMPOTENCE)
    __kafka_compression_type: str = get_env().KAFKA_COMPRESSION_TYPE
    __kafka_linger_ms: str = get_env().KAFKA_LINGER_MS
    __kafka_message_max_bytes: str = get_env().KAFKA_MESSAGE_MAX_BYTES
    __kafka_session_timeout_ms: str = get_env().KAFKA_SESSION_TIMEOUT_MS
    __kafka_fetch_min_bytes: str = get_env().KAFKA_FETCH_MIN_BYTES
    __kafka_fetch_max_bytes: str = get_env().KAFKA_FETCH_MAX_BYTES
    __kafka_fetch_wait_max_ms: int = int(get_env().KAFKA_FETCH_WAITE_MAX_MS)
    __kafka_auto_commit: bool = Helper.str_to_bool(get_env().KAFKA_AUTO_COMMIT)
    __kafka_auto_offset_store: bool = Helper.str_to_bool(get_env().KAFKA_OFFSET_STORE)
    __kafka_auto_offset_reset: str = get_env().KAFKA_OFFSET_RESET    
    __group_id = None
    def __init__(self, group_id: str):
        self.consumer: Consumer = None
        self.__group_id = group_id

    def create_connection(self) -> Consumer:
        conconf = {'bootstrap.servers': self.__kafka_bootstrap_servers,
            'security.protocol': self.__kafka_security_protocol,
            'sasl.mechanism': self.__kafka_sasl_mechanism,
            'sasl.username': self.__kafka_sasl_username,
            'sasl.password': self.__kafka_sasl_password,
            'ssl.ca.location': self.__kafka_ca_file,
            'ssl.certificate.location': self.__kafka_cert_file,
            'ssl.key.location': self.__kafka_key_file, 
            'session.timeout.ms' : self.__kafka_session_timeout_ms,
            'connections.max.idle.ms': self.__kafka_conn_max_idle_ms,
            'retry.backoff.ms': self.__kafka_retry_backoff_ms,
            'socket.keepalive.enable': self.__kafka_socket_keepalive, 
            'fetch.min.bytes': self.__kafka_fetch_min_bytes,
            'fetch.max.bytes': self.__kafka_fetch_max_bytes,
            'fetch.wait.max.ms': self.__kafka_fetch_wait_max_ms,
            'log_level': self.__kafka_log_level,
            'enable.auto.commit': self.__kafka_auto_commit,
            'enable.auto.offset.store': self.__kafka_auto_offset_store,
            'auto.offset.reset': self.__kafka_auto_offset_reset,
            'group.id': self.__group_id,
            'client.id': socket.gethostname()}
        try:
            if self.consumer is None:
                self.consumer = Consumer(conconf)
            return self.consumer
        except Exception as e:
            logger.error(f"Failed to create producer kafka connection: {e}")
            sys.exit(1)

    def get_connection(self) -> Consumer:
        return self.create_connection()