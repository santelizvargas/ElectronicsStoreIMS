import { PrismaClient } from '@prisma/client';
import { CrudRepository } from '../../../../shared/domain/models/repository/CrudRepository';
import { Product } from '../../../domain/models/products/Product';
import { ProductRequest } from '../../../application/products/CreateProductService';

export default class PrismaProductRepository implements CrudRepository<ProductRequest, Product> {
  constructor(private readonly database: PrismaClient) {}

  async findAll(): Promise<Product[]> {
    return this.database.product.findMany();
  }

  async find(id: number): Promise<Product | null> {
    return this.database.product.findUnique({
      where: {
        id,
      },
    });
  }

  async create(model: ProductRequest): Promise<Product> {
    return this.database.product.create({
      data: {
        ...model,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
    });
  }

  async update(model: Omit<Product, 'images'>): Promise<void> {
    this.database.product.update({
      where: {
        id: model.id,
      },
      data: model,
    });
  }

  async delete(id: number): Promise<void> {
    this.database.product.delete({
      where: {
        id,
      },
    });
  }
}
