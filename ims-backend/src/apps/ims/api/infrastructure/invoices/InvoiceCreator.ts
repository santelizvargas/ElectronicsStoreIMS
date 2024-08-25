import { Invoice } from '@prisma/client';
import { Creator } from '../../../shared/domain/Creator';
import { CrudRepository } from '../../../shared/domain/models/repository/CrudRepository';
import { CreateInvoiceRequest, CreateInvoiceResponse } from '../../application/invoices/CreateInvoiceService';
import httpStatus from 'http-status';

export default class InvoiceCreator implements Creator<CreateInvoiceRequest, CreateInvoiceResponse> {
  constructor(private readonly invoiceRepository: CrudRepository<CreateInvoiceRequest, Invoice>) {}

  async invoke(request: CreateInvoiceRequest): Promise<CreateInvoiceResponse> {
    const invoice: Invoice = await this.invoiceRepository.create(request);
    return {
      message: 'Invoice created',
      code: httpStatus.CREATED,
      data: invoice,
    };
  }
}
