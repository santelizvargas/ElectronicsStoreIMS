import { Fetcher } from '../../../shared/domain/Fetcher';
import { CrudRepository } from '../../../shared/domain/models/repository/CrudRepository';
import { FetchProductResponse } from '../../application/products/FetchProductService';
import { Product } from '../../domain/models/products/Product';

export default class ProductFetcher implements Fetcher<FetchProductResponse> {
  constructor(private readonly productRepository: CrudRepository<FetchProductResponse, Product>) {}

  async invoke(): Promise<FetchProductResponse> {
    const products = await this.productRepository.findAll();
    return {
      data: products,
    };
  }
}
