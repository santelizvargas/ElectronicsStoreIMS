import { Product } from '../Product';

export interface ProductRepository {
  supply(id: number, stock: number): Promise<Product>;
  count(): Promise<number>;
}
