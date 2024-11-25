from apscheduler.schedulers.asyncio import AsyncIOScheduler
from loguru import logger
from utils.helpers.singleton import SingletonMeta
import sys
sys.path.append('/')
sys.tracebacklimit = 0

class Scheduler(metaclass=SingletonMeta):
    def __init__(self):
        self._scheduler = None
        self.__get_scheduler()

    def __get_scheduler(self) -> None:
        try:
            if self._scheduler is None:
                self._scheduler = AsyncIOScheduler()
                self._scheduler.start()
            else:
                logger.info("The scheduler was created")
        except Exception as e:
            logger.error(f"Failed to create scheduler: {e}")

    def add_async_job(self, job, trigger) -> None:
        try:
            self._scheduler.add_job(job, trigger)
        except Exception as e:
            logger.error(f"Failed to add job: {e}")

    def stop_scheduler(self) -> None:
        try:
            if self._scheduler is not None:
                self._scheduler.shutdown()
                logger.info("The scheduler was closed!")
            else:
                raise Exception("The scheduler wasn't created")
        except Exception as e:
            logger.error(f"Failed to stop job: {e}")
