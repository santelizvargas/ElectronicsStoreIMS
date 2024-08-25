import type { Request, Response, NextFunction } from 'express';
import status from 'http-status';
import { Controller } from '../../../../../shared/infrastructure/express/controllers/Controller';
import { ErrorHandler } from '../../../../../shared/domain/ErrorHandler';
import { body } from 'express-validator';
import { RequestValidator } from '../../../../../shared/infrastructure/express/RequestValidator';
import EnableUserService, { EnableUserResponse } from '../../../../application/authentication/EnableUserService';

export default class EnableController implements Controller {
  public readonly rules = [body('id').trim().isNumeric().withMessage('Please give a valid id'), RequestValidator];

  constructor(private enableService: EnableUserService) {}

  async invoke(request: Request, response: Response, next: NextFunction): Promise<Response | void> {
    try {
      const authenticationResponse: EnableUserResponse = await this.enableService.invoke({
        id: parseInt(request.body.id),
      });

      response.json(authenticationResponse).status(status.OK);
    } catch (error) {
      const { message } = error as Error;
      const errorHandler = new ErrorHandler(message, status.UNAUTHORIZED);
      next(response.json(errorHandler.toJson()));
    }
  }
}
