import { CountProductResponse } from '../../application/products/CountProductService';

export interface Counter {
  invoke(): Promise<CountProductResponse>;
}
