from abc import ABC, abstractmethod
from uuid import UUID


class IFileRepository[T](ABC):
    @abstractmethod
    def get(self, file_id: UUID) -> T:
        raise NotImplementedError

    @abstractmethod
    def get_all(self) -> list[T]:
        raise NotImplementedError

    @abstractmethod
    def add(self, **kwargs: object) -> None:
        raise NotImplementedError

    @abstractmethod
    def update(self, **kwargs: object) -> None:
        raise NotImplementedError
