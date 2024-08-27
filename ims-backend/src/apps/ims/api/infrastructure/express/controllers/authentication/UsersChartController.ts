import type { Request, Response, NextFunction } from 'express';
import status from 'http-status';
import { Controller } from '../../../../../shared/infrastructure/express/controllers/Controller';
import { ErrorHandler } from '../../../../../shared/domain/ErrorHandler';
import PrismaAuthenticationRepository from '../../../authentication/repositories/PrismaAuthenticationRepository';

export default class UsersChartController implements Controller {
  constructor(private readonly authenticationRepository: PrismaAuthenticationRepository) {}

  async invoke(_: Request, response: Response, next: NextFunction): Promise<Response | void> {
    try {
      const chartResult = await this.authenticationRepository.usersChart();
      return response.json(chartResult).status(status.OK);
    } catch (error) {
      const { message } = error as Error;
      const errorHandler = new ErrorHandler(message, status.UNAUTHORIZED);
      next(response.json(errorHandler.toJson()));
    }
  }
}
