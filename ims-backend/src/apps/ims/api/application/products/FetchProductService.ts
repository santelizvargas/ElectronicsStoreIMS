import { Fetcher } from '../../../shared/domain/Fetcher';
import { Logger } from '../../../shared/domain/Logger';
import { Product } from '../../domain/models/products/Product';

export type FetchProductResponse = {
  data: Product[];
};

export default class FetchProductService {
  constructor(
    private readonly logger: Logger,
    private readonly productFetcher: Fetcher<FetchProductResponse>,
  ) {}

  async invoke(): Promise<FetchProductResponse> {
    this.logger.info('Fetching products');
    return await this.productFetcher.invoke();
  }
}
