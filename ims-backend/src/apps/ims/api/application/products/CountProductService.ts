import { Logger } from '../../../shared/domain/Logger';
import { Counter } from '../../domain/products/Counter';

export type CountProductResponse = {
  message: string;
  data: { quantity: number };
};

export default class CountProductService {
  constructor(
    private readonly logger: Logger,
    private readonly productCounter: Counter,
  ) {}

  public async invoke(): Promise<CountProductResponse> {
    this.logger.info('Counting products');
    return this.productCounter.invoke();
  }
}
