import status from 'http-status';
import { Remover } from '../../../shared/domain/Remover';
import { CrudRepository } from '../../../shared/domain/models/repository/CrudRepository';
import { RemoveProductRequest, RemoveProductResponse } from '../../application/products/RemoveProductService';
import { Product } from '../../domain/models/products/Product';

export default class ProductRemover implements Remover<RemoveProductRequest, RemoveProductResponse> {
  constructor(private readonly productRepository: CrudRepository<RemoveProductRequest, Product>) {}

  async invoke(request: RemoveProductRequest): Promise<RemoveProductResponse> {
    await this.productRepository.delete(request.id);
    return {
      message: 'Product removed',
      code: status.OK,
    };
  }
}
