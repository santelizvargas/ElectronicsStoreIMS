import { NextFunction, Request, Response } from 'express';
import { body } from 'express-validator';
import status from 'http-status';
import { Controller } from '../../../../../shared/infrastructure/express/controllers/Controller';
import { RequestValidator } from '../../../../../shared/infrastructure/express/RequestValidator';
import { ErrorHandler } from '../../../../../shared/domain/ErrorHandler';
import RemoveProductService, {
  RemoveProductRequest,
  RemoveProductResponse,
} from '../../../../application/products/RemoveProductService';

export default class RemoveProductController implements Controller {
  public readonly rules = [body('id').isNumeric().withMessage('Please give a valid id'), RequestValidator];

  constructor(private readonly removeProductService: RemoveProductService) {}

  async invoke(request: Request, response: Response, next: NextFunction): Promise<Response | void> {
    try {
      const productData = request.body as RemoveProductRequest;
      const productResponse: RemoveProductResponse = await this.removeProductService.invoke(productData);

      return response.json(productResponse).status(status.OK);
    } catch (error) {
      const { message } = error as Error;
      const errorHandler = new ErrorHandler(message, status.INTERNAL_SERVER_ERROR);
      next(response.json(errorHandler.toJson()));
    }
  }
}
