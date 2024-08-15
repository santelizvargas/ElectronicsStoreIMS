import { PrismaClient } from '@prisma/client';
import { CrudRepository } from '../../../../shared/domain/models/repository/CrudRepository';
import { Product } from '../../../domain/models/products/Product';
import { ProductRequest } from '../../../application/products/CreateProductService';
import { ProductRepository } from '../../../domain/models/products/repositories/ProductRepository';

export default class PrismaProductRepository implements ProductRepository, CrudRepository<ProductRequest, Product> {
  constructor(private readonly database: PrismaClient) {}

  async findAll(): Promise<Product[]> {
    return await this.database.product.findMany({
      where: {
        deletedAt: null,
      },
    });
  }

  async find(id: number): Promise<Product | null> {
    return await this.database.product.findUnique({
      where: {
        id,
      },
    });
  }

  async create(model: ProductRequest): Promise<Product> {
    return await this.database.product.create({
      data: {
        ...model,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
    });
  }

  async update(model: Omit<Product, 'images'>): Promise<void> {
    await this.database.product.update({
      where: {
        id: model.id,
      },
      data: model,
    });
  }

  async delete(id: number): Promise<void> {
    await this.database.product.delete({
      where: {
        id,
      },
    });
  }

  async supply(id: number, stock: number): Promise<Product> {
    return await this.database.product.update({
      where: {
        id,
      },
      data: {
        stock: {
          increment: stock,
        },
      },
    });
  }

  async count(): Promise<number> {
    return await this.database.product.count();
  }
}
