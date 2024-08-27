import { Invoice } from '@prisma/client';
import { Logger } from 'winston';
import { Creator } from '../../../shared/domain/Creator';

export type CreateInvoiceRequest = Omit<Invoice, 'id' | 'createdAt' | 'updatedAt' | 'deletedAt'> & {
  products: { id: number; name: string; quantity: number; price: number; category: string }[];
};

export type CreateInvoiceResponse = {
  message: string;
  code: number;
  data: Invoice;
};

export default class CreateInvoiceService {
  constructor(
    private readonly logger: Logger,
    private readonly invoiceCreator: Creator<CreateInvoiceRequest, CreateInvoiceResponse>,
  ) {}

  public async invoke(request: CreateInvoiceRequest): Promise<CreateInvoiceResponse> {
    this.logger.info('Creating invoice');
    return this.invoiceCreator.invoke(request);
  }
}
