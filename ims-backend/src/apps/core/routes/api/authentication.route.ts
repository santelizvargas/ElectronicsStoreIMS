import { Express } from 'express';
import AuthenticationController from '../../../ims/api/infrastructure/express/controllers/AuthenticationController';
import Container from '../../di/Container';
import UpdatePasswordController from '../../../ims/api/infrastructure/express/controllers/UpdatePasswordController';

export const register = function (app: Express): void {
  const container = new Container().invoke();
  const authenticationController: AuthenticationController =
    container.resolve<AuthenticationController>('authenticationController');
  const updatePasswordController: UpdatePasswordController =
    container.resolve<UpdatePasswordController>('updatePasswordController');
  app.post(
    '/auth/login',
    authenticationController.rules,
    authenticationController.invoke.bind(authenticationController),
  );

  app.put(
    '/auth/password',
    updatePasswordController.rules,
    updatePasswordController.invoke.bind(updatePasswordController),
  );
};
