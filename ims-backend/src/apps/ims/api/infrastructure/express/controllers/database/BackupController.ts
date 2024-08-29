import { NextFunction, Request, Response } from 'express';
import { execute } from '@getvim/execute';
import status from 'http-status';
import { Controller } from '../../../../../shared/infrastructure/express/controllers/Controller';
import { ErrorHandler } from '../../../../../shared/domain/ErrorHandler';
import DatabaseConfig from '../../../../../../core/config/DatabaseConfig';

export default class BackupController implements Controller {
  constructor(private readonly databaseConfig: DatabaseConfig) {}

  async invoke(request: Request, response: Response, next: NextFunction): Promise<Response | void> {
    try {
      const backupFile = backupFileName();
      await execute(
        `pg_dump --format=c -x --no-privileges --no-owner --no-acl -Ft --dbname ${this.databaseConfig.url} > ${backupFile}`,
      );
      return response.json({ message: 'Backup created successfully', code: status.OK }).status(status.OK);
    } catch (error) {
      const { message } = error as Error;
      console.log({ error });
      const errorHandler = new ErrorHandler(message, status.INTERNAL_SERVER_ERROR);
      next(response.json(errorHandler.toJson()));
    }
  }
}

function backupFileName(): string {
  const date = new Date();
  const currentDate = `${date.getFullYear()}-${date.getMonth() + 1}-${date.getDate()}-${date.getHours()}-${date.getMinutes()}`;
  return `backups/database-backup-${currentDate}.sql`;
}
