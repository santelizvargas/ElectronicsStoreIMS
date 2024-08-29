import { NextFunction, Request, Response } from 'express';
import { execute } from '@getvim/execute';
import { body } from 'express-validator';
import status from 'http-status';
import { Controller } from '../../../../../shared/infrastructure/express/controllers/Controller';
import { ErrorHandler } from '../../../../../shared/domain/ErrorHandler';
import { RequestValidator } from '../../../../../shared/infrastructure/express/RequestValidator';
import DatabaseConfig from '../../../../../../core/config/DatabaseConfig';

export default class RestoreController implements Controller {
  public readonly rules = [
    body('backupName').isString().withMessage('Please give a valid backup name'),
    RequestValidator,
  ];

  constructor(private readonly databaseConfig: DatabaseConfig) {}

  async invoke(request: Request, response: Response, next: NextFunction): Promise<Response | void> {
    try {
      // Drop database
      await execute(`pg_restore --clean --dbname ${this.databaseConfig.url} < backups/${request.body.backupName}`);
      return response.json({ message: 'Backup restored successfully', code: status.OK }).status(status.OK);
    } catch (error) {
      const { message } = error as Error;
      console.log({ error });
      const errorHandler = new ErrorHandler(message, status.INTERNAL_SERVER_ERROR);
      next(response.json(errorHandler.toJson()));
    }
  }
}
