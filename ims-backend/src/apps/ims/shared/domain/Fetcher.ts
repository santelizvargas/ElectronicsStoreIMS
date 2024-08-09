import { FetchProductResponse } from '../../api/application/products/FetchProductService';

export interface Fetcher {
  invoke(): Promise<FetchProductResponse>;
}
