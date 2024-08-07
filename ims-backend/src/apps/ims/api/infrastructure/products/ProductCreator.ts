import { Creator } from '../../../shared/domain/Creator';
import { CrudRepository } from '../../../shared/domain/models/repository/CrudRepository';
import { ProductRequest, ProductResponse } from '../../application/products/CreateProductService';
import { Product } from '../../domain/models/products/Product';

export default class ProductCreator implements Creator<ProductRequest, ProductResponse> {
  constructor(private readonly productRepository: CrudRepository<ProductRequest, Product>) {}

  async invoke(request: ProductRequest): Promise<ProductResponse> {
    const product: Product = await this.productRepository.create(request);
    return {
      message: 'Product created',
      code: 201,
      data: product,
    };
  }
}
