import { NextFunction, Request, Response } from 'express';
import status from 'http-status';
import { Controller } from '../../../../../shared/infrastructure/express/controllers/Controller';
import { ErrorHandler } from '../../../../../shared/domain/ErrorHandler';
import PrismaProductRepository from '../../../products/repositories/PrismaProductRepository';

export default class CountInvoiceController implements Controller {
  constructor(private readonly invoiceRepository: PrismaProductRepository) {}

  async invoke(request: Request, response: Response, next: NextFunction): Promise<Response | void> {
    try {
      const invoicesCount: number = await this.invoiceRepository.count();
      const invoiceResponse = { count: invoicesCount };
      return response.json(invoiceResponse).status(status.CREATED);
    } catch (error) {
      const { message } = error as Error;
      const errorHandler = new ErrorHandler(message, status.INTERNAL_SERVER_ERROR);
      next(response.json(errorHandler.toJson()));
    }
  }
}
