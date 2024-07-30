class ProductEntity(object):
    """
    Product entity
    """ 
    
    def __init__(
        self,
        id: int | None,
        name: str,
        description: str | None,
        brand: str,
        sale_price: float,
        purchase_price: float,
        stock: int = 0,
    ):
        self.id = id
        self.name = name
        self.description = description
        self.brand = brand
        self.sale_price = sale_price
        self.purchase_price = purchase_price
        self.stock = stock
        
    def __eq__(self, other: object) -> bool:
        if isinstance(other, ProductEntity):
            return self.id == other.id

        return False
