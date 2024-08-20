import type { Request, Response, NextFunction } from 'express';
import status from 'http-status';
import { Controller } from '../../../../../shared/infrastructure/express/controllers/Controller';
import { ErrorHandler } from '../../../../../shared/domain/ErrorHandler';
import { body } from 'express-validator';
import { RequestValidator } from '../../../../../shared/infrastructure/express/RequestValidator';
import RegistrationService, { RegistrationResponse } from '../../../../application/authentication/RegistrationService';

export default class RegisterController implements Controller {
  public readonly rules = [
    body('firstName').trim().isLength({ min: 2 }).withMessage('Please give a valid first name'),
    body('lastName').trim().isLength({ min: 2 }).withMessage('Please give a valid last name'),
    body('email').trim().normalizeEmail().isEmail().withMessage('Please give a valid email'),
    body('identification').trim().isLength({ min: 5 }).withMessage('Please give a valid identification'),
    body('phone').trim().isLength({ min: 8 }).withMessage('Please give a valid phone'),
    body('address').trim().isLength({ min: 2 }).withMessage('Please give a valid address'),
    body('password').trim().isLength({ min: 8 }).withMessage('Please give a valid password'),
    body('confirmPassword').trim().isLength({ min: 8 }).withMessage('Please give a valid confirm password'),
    RequestValidator,
  ];

  constructor(private registrationService: RegistrationService) {}

  async invoke(request: Request, response: Response, next: NextFunction): Promise<Response | void> {
    try {
      const authenticationResponse: RegistrationResponse = await this.registrationService.invoke({
        ...request.body,
      });
      response.setHeader('Authorization', `Bearer ${authenticationResponse.accessToken}`);
      return response.json(authenticationResponse).status(status.OK);
    } catch (error) {
      const { message } = error as Error;
      const errorHandler = new ErrorHandler(message, status.UNAUTHORIZED);
      next(response.json(errorHandler.toJson()));
    }
  }
}
