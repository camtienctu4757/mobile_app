from abc import ABC, abstractmethod
from uuid import UUID
from thirdparty.db.models.users import User

class IUserRepository[T](ABC):
    @abstractmethod
    def get(self, user_id: UUID) -> User :
        raise NotImplementedError

    @abstractmethod
    def add_user(self, **kwargs: object) -> None:
        raise NotImplementedError

    @abstractmethod
    def update_user(self, **kwargs: object) -> T:
        raise NotImplementedError
    
    @abstractmethod
    def delete(self, user_id: UUID) -> None:
        raise NotImplementedError
