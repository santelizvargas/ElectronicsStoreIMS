import { Creator } from '../../../shared/domain/Creator';
import { Logger } from '../../../shared/domain/Logger';
import { Product } from '../../domain/models/products/Product';

export type ProductRequest = Omit<Product, 'id' | 'images' | 'createdAt' | 'updatedAt' | 'deletedAt'>;
export type ProductResponse = {
  message: string;
  code: number;
  data: Product;
};

export default class CreateProductService {
  constructor(
    private readonly logger: Logger,
    private readonly productCreator: Creator<ProductRequest, ProductResponse>,
  ) {}

  public async create(request: ProductRequest): Promise<ProductResponse> {
    this.logger.info(`Creating product: ${request.name}`);
    return this.productCreator.invoke(request);
  }
}
