import { NextFunction, Request, Response } from 'express';
import { execute } from '@getvim/execute';
import status from 'http-status';
import { Controller } from '../../../../../shared/infrastructure/express/controllers/Controller';
import { ErrorHandler } from '../../../../../shared/domain/ErrorHandler';

export default class ListController implements Controller {
  async invoke(request: Request, response: Response, next: NextFunction): Promise<Response | void> {
    try {
      const backupFiles = await execute('ls backups');
      const filteredBackupFiles = backupFiles.split('\n').filter((file: string) => file !== '');
      return response.json({ data: filteredBackupFiles }).status(status.OK);
    } catch (error) {
      const { message } = error as Error;
      console.log({ error });
      const errorHandler = new ErrorHandler(message, status.INTERNAL_SERVER_ERROR);
      next(response.json(errorHandler.toJson()));
    }
  }
}
