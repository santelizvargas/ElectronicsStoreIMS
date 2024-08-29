import { Invoice, PrismaClient } from '@prisma/client';
import { CrudRepository } from '../../../../shared/domain/models/repository/CrudRepository';
import { CreateInvoiceRequest } from '../../../application/invoices/CreateInvoiceService';

export default class PrismaInvoiceRepository implements CrudRepository<CreateInvoiceRequest, Invoice> {
  constructor(private readonly database: PrismaClient) {}

  async findAll(): Promise<Invoice[]> {
    return await this.database.invoice.findMany({
      include: {
        products: true,
        details: true,
      },
    });
  }

  async find(id: number): Promise<Invoice | null> {
    return await this.database.invoice.findUnique({
      where: {
        id,
      },
    });
  }

  async create(model: CreateInvoiceRequest): Promise<Invoice> {
    return await this.database.invoice.create({
      data: {
        ...model,
        createdAt: new Date(),
        products: {
          connect: model.products.map((product) => ({
            id: product.id,
          })),
        },
        details: {
          create: model.products.map((product) => ({
            productName: product.name,
            productQuantity: product.quantity,
            productPrice: product.price,
            productCategory: product.category,
            createdAt: new Date(),
          })),
        },
      },
      include: {
        products: true,
        details: true,
      },
    });
  }

  async update(model: CreateInvoiceRequest): Promise<void> {
    await this.database.invoice.update({
      where: {
        id: 1, // This is a dummy value, it should be replaced with the actual id
        customerName: model.customerName,
      },
      data: {
        ...model,
        products: {
          connect: [],
        },
      },
    });
  }

  async delete(id: number): Promise<void> {
    await this.database.invoice.delete({
      where: {
        id,
      },
    });
  }

  async count(): Promise<number> {
    return await this.database.invoice.count();
  }
}
