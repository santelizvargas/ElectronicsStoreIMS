import { NextFunction, Request, Response } from 'express';
import { body } from 'express-validator';
import status from 'http-status';
import { Controller } from '../../../../../shared/infrastructure/express/controllers/Controller';
import { RequestValidator } from '../../../../../shared/infrastructure/express/RequestValidator';
import CreateProductService, {
  ProductRequest,
  ProductResponse,
} from '../../../../application/products/CreateProductService';
import { ErrorHandler } from '../../../../../shared/domain/ErrorHandler';

export default class CreateProductController implements Controller {
  public readonly rules = [
    body('name').trim().isString().withMessage('Please give a valid name'),
    body('description').optional().trim().isString().withMessage('Please give a valid description'),
    body('salePrice').isNumeric().withMessage('Please give a valid sale price'),
    body('purchasePrice').isNumeric().withMessage('Please give a valid purchase price'),
    body('stock').isNumeric().withMessage('Please give a valid stock'),
    RequestValidator,
  ];

  constructor(private readonly createProductService: CreateProductService) {}

  async invoke(request: Request, response: Response, next: NextFunction): Promise<Response | void> {
    try {
      const productData = request.body as ProductRequest;
      const productResponse: ProductResponse = await this.createProductService.create(productData);

      return response.json(productResponse).status(status.CREATED);
    } catch (error) {
      const { message } = error as Error;
      const errorHandler = new ErrorHandler(message, status.INTERNAL_SERVER_ERROR);
      next(response.json(errorHandler.toJson()));
    }
  }
}
