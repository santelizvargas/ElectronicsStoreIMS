from sqlalchemy import Column, Boolean, String
from sqlalchemy.orm import Mapped
from v1.core.models.postgres.base import Base


class Product(Base):
    """
    Product model
    """
    
    __tablename__ = 'products'
    
    name: Mapped[str] | str = Column(String, unique=True, index=True)
    description: Mapped[str] | str = Column(String, nullable=True)
    brand: Mapped[str] | str = Column(String, index=True)
    sale_price: Mapped[float] | float = Column(float)
    purchase_price: Mapped[float] | float = Column(float)
    stock: Mapped[int] | int = Column(int, default=0)

    # TODO: Add relationships
