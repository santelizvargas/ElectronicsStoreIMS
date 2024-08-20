import type { Request, Response, NextFunction } from 'express';
import status from 'http-status';
import { Controller } from '../../../../../shared/infrastructure/express/controllers/Controller';
import { ErrorHandler } from '../../../../../shared/domain/ErrorHandler';
import FetchAuthenticationService, {
  FetchResponse,
} from '../../../../application/authentication/FetchAuthenticationService';

export default class AuthenticationFetchController implements Controller {
  constructor(private fetchAuthenticationService: FetchAuthenticationService) {}

  async invoke(_: Request, response: Response, next: NextFunction): Promise<Response | void> {
    try {
      const authenticationResponse: FetchResponse = await this.fetchAuthenticationService.invoke();
      return response.json(authenticationResponse).status(status.OK);
    } catch (error) {
      const { message } = error as Error;
      const errorHandler = new ErrorHandler(message, status.UNAUTHORIZED);
      next(response.json(errorHandler.toJson()));
    }
  }
}
