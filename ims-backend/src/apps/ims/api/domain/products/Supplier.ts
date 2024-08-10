import { SupplyProductRequest, SupplyProductResponse } from '../../application/products/SupplyProductService';

export interface Supplier {
  invoke(request: SupplyProductRequest): Promise<SupplyProductResponse>;
}
