import { Express } from 'express';
import Container from '../../di/Container';
import AssignRoleController from '../../../ims/api/infrastructure/express/controllers/rbac/AssignRoleController';
import RevokeRoleController from '../../../ims/api/infrastructure/express/controllers/rbac/RevokeRoleController';

export const register = function (app: Express): void {
  const container = new Container().invoke();
  const assignRoleController: AssignRoleController = container.resolve<AssignRoleController>('assignRoleController');
  const revokeRoleController: RevokeRoleController = container.resolve<RevokeRoleController>('revokeRoleController');
  app.post('/rbac/roles', assignRoleController.rules, assignRoleController.invoke.bind(assignRoleController));
  app.delete('/rbac/roles', revokeRoleController.rules, revokeRoleController.invoke.bind(revokeRoleController));
};
