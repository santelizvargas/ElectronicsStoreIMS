import { NextFunction, Request, Response } from 'express';
import { body } from 'express-validator';
import status from 'http-status';
import { Controller } from '../../../../../shared/infrastructure/express/controllers/Controller';
import { RequestValidator } from '../../../../../shared/infrastructure/express/RequestValidator';
import { ErrorHandler } from '../../../../../shared/domain/ErrorHandler';
import CreateInvoiceService, { CreateInvoiceResponse } from '../../../../application/invoices/CreateInvoiceService';
import { CrudRepository } from '../../../../../shared/domain/models/repository/CrudRepository';
import { Product } from '@prisma/client';

export default class CreateInvoiceController implements Controller {
  public readonly rules = [
    body('customerName').isString().withMessage('Please give a valid customer name'),
    body('customerIdentification').isString().withMessage('Please give a valid customer identification'),
    body('totalAmount').isNumeric().withMessage('Please give a valid total amount'),
    RequestValidator,
  ];

  constructor(
    private readonly createInvoiceService: CreateInvoiceService,
    private readonly productRepository: CrudRepository<{ id: number; stock: number }, Product>,
  ) {}

  async invoke(request: Request, response: Response, next: NextFunction): Promise<Response | void> {
    try {
      // We need to update the product stock
      request.body.products.forEach(async (product: { id: number; quantity: number }) => {
        const foundProduct = await this.productRepository.find(product.id);
        const productStock = foundProduct?.stock || 0;

        if (productStock < product.quantity) {
          return next(
            response.json({
              message: `Not enough stock for the product ${foundProduct?.name || product.id}`,
              code: status.BAD_REQUEST,
            }),
          );
        }

        const newStock = productStock - product.quantity;

        this.productRepository.update({
          id: product.id,
          stock: newStock,
        });
      });

      const invoiceResponse: CreateInvoiceResponse = await this.createInvoiceService.invoke(request.body);

      return response.json(invoiceResponse).status(status.CREATED);
    } catch (error) {
      const { message } = error as Error;
      const errorHandler = new ErrorHandler(message, status.INTERNAL_SERVER_ERROR);
      next(response.json(errorHandler.toJson()));
    }
  }
}
