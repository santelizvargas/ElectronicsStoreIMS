from abc import abstractmethod
from typing import Sequence
from v1.features.infrastructure.shared.repositories.base_repository import BaseRepository
from v1.features.infrastructure.products.entities.product_entity import ProductEntity


class ProductRepositoryContract(BaseRepository[ProductEntity]):
    """
    Product repository contract
    """
    
    @abstractmethod
    def find_by_name(self, name: str) -> ProductEntity | None:
        raise NotImplementedError()
    
    @abstractmethod
    def find_by_brand(self, brand: str) -> Sequence[ProductEntity]:
        raise NotImplementedError()
