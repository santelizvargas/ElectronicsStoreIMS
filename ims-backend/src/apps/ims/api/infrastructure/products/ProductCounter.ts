import { CountProductResponse } from '../../application/products/CountProductService';
import { ProductRepository } from '../../domain/models/products/repositories/ProductRepository';
import { Counter } from '../../domain/products/Counter';

export default class ProductCounter implements Counter {
  constructor(private readonly productRepository: ProductRepository) {}

  async invoke(): Promise<CountProductResponse> {
    const productsCount: number = await this.productRepository.count();
    return {
      message: 'Products counted',
      data: { quantity: productsCount },
    };
  }
}
