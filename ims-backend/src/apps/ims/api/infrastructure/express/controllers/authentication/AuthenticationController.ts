import type { Request, Response, NextFunction } from 'express';
import status from 'http-status';
import { Controller } from '../../../../../shared/infrastructure/express/controllers/Controller';
import AuthenticationService, {
  AuthenticationResponse,
} from '../../../../application/authentication/AuthenticationService';
import { ErrorHandler } from '../../../../../shared/domain/ErrorHandler';
import { body } from 'express-validator';
import { RequestValidator } from '../../../../../shared/infrastructure/express/RequestValidator';

export default class AuthenticationController implements Controller {
  public readonly rules = [
    body('email').trim().normalizeEmail().isEmail().withMessage('Please give a valid email'),
    body('password').trim().isLength({ min: 8 }).withMessage('Please give a valid password'),
    RequestValidator,
  ];

  constructor(private authenticationService: AuthenticationService) {}

  async invoke(request: Request, response: Response, next: NextFunction): Promise<Response | void> {
    try {
      const authenticationResponse: AuthenticationResponse = await this.authenticationService.invoke({
        email: request.body.email,
        password: request.body.password,
      });

      response.setHeader('Authorization', `Bearer ${authenticationResponse.accessToken}`);
      response.json(authenticationResponse).status(status.OK);
    } catch (error) {
      const { message } = error as Error;
      const errorHandler = new ErrorHandler(message, status.UNAUTHORIZED);
      next(response.json(errorHandler.toJson()));
    }
  }
}
