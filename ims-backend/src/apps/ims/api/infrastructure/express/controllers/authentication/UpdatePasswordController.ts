import type { Request, Response, NextFunction } from 'express';
import status from 'http-status';
import { Controller } from '../../../../../shared/infrastructure/express/controllers/Controller';
import { ErrorHandler } from '../../../../../shared/domain/ErrorHandler';
import { body } from 'express-validator';
import { RequestValidator } from '../../../../../shared/infrastructure/express/RequestValidator';
import UpdatePasswordService, {
  UpdatePasswordResponse,
} from '../../../../application/authentication/UpdatePasswordService';

export default class UpdatePasswordController implements Controller {
  public readonly rules = [
    body('email').trim().normalizeEmail().isEmail().withMessage('Please give a valid email'),
    body('currentPassword').trim().isLength({ min: 8 }).withMessage('Please give a valid password'),
    body('password').trim().isLength({ min: 8 }).withMessage('Please give a valid password'),
    body('confirmPassword').trim().isLength({ min: 8 }).withMessage('Please give a valid confirm password'),
    RequestValidator,
  ];

  constructor(private updatePasswordService: UpdatePasswordService) {}

  async invoke(request: Request, response: Response, next: NextFunction): Promise<Response | void> {
    try {
      const authenticationResponse: UpdatePasswordResponse = await this.updatePasswordService.invoke({
        ...request.body,
      });

      response.json(authenticationResponse).status(status.OK);
    } catch (error) {
      const { message } = error as Error;
      const errorHandler = new ErrorHandler(message, status.UNAUTHORIZED);
      next(response.json(errorHandler.toJson()));
    }
  }
}
