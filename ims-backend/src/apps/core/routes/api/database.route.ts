import { Express } from 'express';
import Container from '../../di/Container';
import BackupController from '../../../ims/api/infrastructure/express/controllers/database/BackupController';
import RestoreController from '../../../ims/api/infrastructure/express/controllers/database/RestoreController';
import ListController from '../../../ims/api/infrastructure/express/controllers/database/ListController';

export const register = function (app: Express): void {
  const container = new Container().invoke();
  const backupController: BackupController = container.resolve<BackupController>('backupController');
  const restoreController: RestoreController = container.resolve<RestoreController>('restoreController');
  const listController: ListController = container.resolve<ListController>('listController');

  app.post('/database/backup', backupController.invoke.bind(backupController));
  app.post('/database/restore', restoreController.invoke.bind(restoreController));
  app.get('/database/list', listController.invoke.bind(listController));
};
