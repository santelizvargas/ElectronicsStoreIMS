import { Express } from 'express';
import Container from '../../di/Container';
import AssignRoleController from '../../../ims/api/infrastructure/express/controllers/rbac/AssignRoleController';

export const register = function (app: Express): void {
  const container = new Container().invoke();
  const assignRoleController: AssignRoleController = container.resolve<AssignRoleController>('assignRoleController');
  app.post('/rbac/roles', assignRoleController.rules, assignRoleController.invoke.bind(assignRoleController));
};
