import { NextFunction, Request, Response } from 'express';
import { body } from 'express-validator';
import status from 'http-status';
import { Controller } from '../../../../../shared/infrastructure/express/controllers/Controller';
import { RequestValidator } from '../../../../../shared/infrastructure/express/RequestValidator';
import { ErrorHandler } from '../../../../../shared/domain/ErrorHandler';
import SupplyProductService, {
  SupplyProductRequest,
  SupplyProductResponse,
} from '../../../../application/products/SupplyProductService';

export default class SupplyProductController implements Controller {
  public readonly rules = [
    body('id').isNumeric().withMessage('Please give a valid id'),
    body('stock').isNumeric().withMessage('Please give a valid stock'),
    RequestValidator,
  ];

  constructor(private readonly supplyProductService: SupplyProductService) {}

  async invoke(request: Request, response: Response, next: NextFunction): Promise<Response | void> {
    try {
      const productData = request.body as SupplyProductRequest;
      const productResponse: SupplyProductResponse = await this.supplyProductService.invoke(productData);

      return response.json(productResponse).status(status.OK);
    } catch (error) {
      const { message } = error as Error;
      const errorHandler = new ErrorHandler(message, status.INTERNAL_SERVER_ERROR);
      next(response.json(errorHandler.toJson()));
    }
  }
}
