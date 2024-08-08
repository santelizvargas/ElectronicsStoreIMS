import { Product } from '@prisma/client';
import { Fetcher } from '../../../shared/domain/Fetcher';
import { CrudRepository } from '../../../shared/domain/models/repository/CrudRepository';
import { FetchProductResponse } from '../../application/products/FetchProductService';

export default class ProductFetcher implements Fetcher {
  constructor(private readonly productRepository: CrudRepository<FetchProductResponse, Product>) {}

  async invoke(): Promise<FetchProductResponse> {
    const products = await this.productRepository.findAll();
    return {
      data: products,
    };
  }
}
