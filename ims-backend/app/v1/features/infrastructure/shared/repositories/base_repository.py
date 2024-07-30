from abc import ABC, abstractmethod
from typing import TypeVar, Sequence, Generic
from v1.core.database.postgres.database import get_session


_T = TypeVar('_T')


class BaseRepository(ABC, Generic[_T]):
    """
    Base repository class that defines the methods that should be implemented by all repositories.
    """
    
    def __init__(self) -> None:
        super().__init__()
        self._database = get_session()

    @abstractmethod
    def create(self, entity: _T) -> _T:
        raise NotImplementedError()
    
    @abstractmethod
    def find_by_id(self, id: int) -> _T | None:
        raise NotImplementedError()

    @abstractmethod
    def find_all(self) -> Sequence[_T]:
        raise NotImplementedError()

    @abstractmethod
    def update(self, entity: _T) -> _T:
        raise NotImplementedError()

    @abstractmethod
    def delete_by_id(self, id: int) -> _T:
        raise NotImplementedError()
