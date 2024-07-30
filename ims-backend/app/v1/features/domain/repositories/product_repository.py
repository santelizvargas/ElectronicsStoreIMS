from v1.features.infrastructure.products.repositories.product_repository_contract import ProductRepositoryContract
from v1.features.infrastructure.products.entities.product_entity import ProductEntity
from typing import Sequence


class ProductRepository(ProductRepositoryContract):
    """
    Concrete Product repository
    """
    
    def create(self, entity: ProductEntity) -> ProductEntity:
        self._database.add(entity)
        return entity
    
    def find_by_id(self, id: int) -> ProductEntity | None:
        return self._database.query(ProductEntity).filter_by(id=id).first()
    
    def find_by_brand(self, brand: str) -> ProductEntity | None:
        return self._database.query(ProductEntity).filter_by(brand=brand).first()
    
    def find_by_name(self, name: str) -> ProductEntity | None:
        return self._database.query(ProductEntity).filter_by(name=name).first()
    
    def find_all(self) -> Sequence[ProductEntity]:
        return self._database.query(ProductEntity).all()
    
    def update(self, entity: ProductEntity) -> ProductEntity:
        self._database._save_or_update_impl(entity)
        return entity
    
    def delete_by_id(self, id: int) -> ProductEntity:
        entity = self.find_by_id(id)
        self._database.delete(entity)
        return entity
