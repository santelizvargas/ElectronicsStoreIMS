import httpStatus from 'http-status';
import { SupplyProductRequest, SupplyProductResponse } from '../../application/products/SupplyProductService';
import { ProductRepository } from '../../domain/models/products/repositories/ProductRepository';
import { Supplier } from '../../domain/products/Supplier';
import { Product } from '../../domain/models/products/Product';

export default class ProductSupplier implements Supplier {
  constructor(private readonly productRepository: ProductRepository) {}

  async invoke(request: SupplyProductRequest): Promise<SupplyProductResponse> {
    const product: Product = await this.productRepository.supply(request.id, request.stock);
    return {
      message: 'Product supplied',
      code: httpStatus.OK,
      data: product,
    };
  }
}
