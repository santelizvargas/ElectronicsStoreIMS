import { NextFunction, Request, Response } from 'express';
import status from 'http-status';
import { Controller } from '../../../../../shared/infrastructure/express/controllers/Controller';
import { ErrorHandler } from '../../../../../shared/domain/ErrorHandler';
import { CrudRepository } from '../../../../../shared/domain/models/repository/CrudRepository';
import { CreateInvoiceRequest } from '../../../../application/invoices/CreateInvoiceService';
import { Invoice } from '@prisma/client';

type FetchInvoiceResponse = {
  data: Invoice[];
};

export default class FetchInvoiceController implements Controller {
  constructor(private readonly invoiceRepository: CrudRepository<CreateInvoiceRequest, Invoice>) {}

  async invoke(request: Request, response: Response, next: NextFunction): Promise<Response | void> {
    try {
      const invoices: Invoice[] = await this.invoiceRepository.findAll();
      const invoiceResponse = { data: invoices } as FetchInvoiceResponse;
      return response.json(invoiceResponse).status(status.CREATED);
    } catch (error) {
      const { message } = error as Error;
      const errorHandler = new ErrorHandler(message, status.INTERNAL_SERVER_ERROR);
      next(response.json(errorHandler.toJson()));
    }
  }
}
