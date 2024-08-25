import { NextFunction, Request, Response } from 'express';
import { body } from 'express-validator';
import status from 'http-status';
import { Controller } from '../../../../../shared/infrastructure/express/controllers/Controller';
import { RequestValidator } from '../../../../../shared/infrastructure/express/RequestValidator';
import { ErrorHandler } from '../../../../../shared/domain/ErrorHandler';
import CreateInvoiceService, { CreateInvoiceResponse } from '../../../../application/invoices/CreateInvoiceService';

export default class CreateInvoiceController implements Controller {
  public readonly rules = [
    body('customerName').isString().withMessage('Please give a valid customer name'),
    body('customerIdentification').isString().withMessage('Please give a valid customer identification'),
    body('totalAmount').isNumeric().withMessage('Please give a valid total amount'),
    RequestValidator,
  ];

  constructor(private readonly createInvoiceService: CreateInvoiceService) {}

  async invoke(request: Request, response: Response, next: NextFunction): Promise<Response | void> {
    try {
      const invoiceResponse: CreateInvoiceResponse = await this.createInvoiceService.invoke(request.body);
      return response.json(invoiceResponse).status(status.CREATED);
    } catch (error) {
      const { message } = error as Error;
      const errorHandler = new ErrorHandler(message, status.INTERNAL_SERVER_ERROR);
      next(response.json(errorHandler.toJson()));
    }
  }
}
