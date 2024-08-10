import { Logger } from '../../../shared/domain/Logger';
import { Remover } from '../../../shared/domain/Remover';

export type RemoveProductRequest = { id: number };
export type RemoveProductResponse = {
  message: string;
  code: number;
};

export default class RemoveProductService {
  constructor(
    private readonly logger: Logger,
    private readonly productRemover: Remover<RemoveProductRequest, RemoveProductResponse>,
  ) {}

  public async invoke(request: RemoveProductRequest): Promise<RemoveProductResponse> {
    this.logger.info(`Removing product: ${request.id}`);
    return this.productRemover.invoke(request);
  }
}
