
import sys
from loguru import logger
from utils.helpers.helpers import Helper
import thirdparty.connections as conn
from confluent_kafka import Producer,Consumer,KafkaError,KafkaException
from thirdparty.kafka.sessions import KafkaProducer,KafkaConsumer
from thirdparty.connections import PostgresConnection
from thirdparty.db.sessions import PostgresDBManager
import asyncio
import time
sys.path.append('/')
sys.tracebacklimit = 0

  # Replace with your Kafka topic

class KafkaExcecute():
    @classmethod
    async def produce(self, topic: str, key: str, value: str):
        try:
          if Helper.is_json_string(value):
              producer = await conn.KafkaProducerConnection.connect()
              producer.produce(topic, key=key, value=value, 
                              callback=lambda err, msg: logger.error(f"The kafka message delivery failed: {err}") if err is not None else None) 
              producer.poll(1)         
          else:
            logger.error(f"The kafka message is not the json string type")
        except Exception as e:
            logger.error(f"{e}")      
    @classmethod
    async def consume(self, func, topics: list[str], group_id: str):
        try:
            consumer = conn.KafkaConsumerConnection(group_id=group_id).connect()
            consumer.subscribe(topics) 
            db_read = await PostgresConnection.connect1(db_type="read")
            db_write = await PostgresConnection.connect1(db_type="write")
            while True:
                msg = consumer.poll(timeout=0.5)
                if msg is None:
                    continue
                if msg.error():
                    if msg.error().code() == KafkaError._PARTITION_EOF:
                        logger.error(f"{msg.topic()},{msg.partition()} , {msg.offset()} reached end at offset")
                        continue
                    else:
                        logger.error(f"Consume message error: {msg.error()}")
                        break
                else:
                    await func(msg,db_read,db_write)
                    consumer.commit(asynchronous=True)
        except Exception as e:
            logger.error(f"Consumer error: {str(e)}")
        finally:
            consumer.close()