import { NextFunction, Request, Response } from 'express';
import status from 'http-status';
import { Controller } from '../../../../../shared/infrastructure/express/controllers/Controller';
import { ErrorHandler } from '../../../../../shared/domain/ErrorHandler';
import FetchProductService, { FetchProductResponse } from '../../../../application/products/FetchProductService';

export default class FetchProductController implements Controller {
  constructor(private readonly fetchProductService: FetchProductService) {}

  async invoke(_: Request, response: Response, next: NextFunction): Promise<Response | void> {
    try {
      const productResponse: FetchProductResponse = await this.fetchProductService.invoke();
      return response.json(productResponse).status(status.OK);
    } catch (error) {
      const { message } = error as Error;
      const errorHandler = new ErrorHandler(message, status.INTERNAL_SERVER_ERROR);
      next(response.json(errorHandler.toJson()));
    }
  }
}
