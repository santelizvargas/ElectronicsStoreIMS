import { Logger } from 'winston';
import { Supplier } from '../../domain/products/Supplier';
import { Product } from '../../domain/models/products/Product';

export type SupplyProductRequest = {
  id: number;
  stock: number;
};

export type SupplyProductResponse = {
  message: string;
  code: number;
  data: Product;
};

export default class SupplyProductService {
  constructor(
    private readonly logger: Logger,
    private readonly productSupplier: Supplier,
  ) {}

  public async invoke(request: SupplyProductRequest): Promise<SupplyProductResponse> {
    this.logger.info(`Supplying product: ${request.id}`);
    return await this.productSupplier.invoke(request);
  }
}
