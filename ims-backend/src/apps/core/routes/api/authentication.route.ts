import { Express } from 'express';
import AuthenticationController from '../../../ims/api/infrastructure/express/controllers/authentication/AuthenticationController';
import Container from '../../di/Container';
import UpdatePasswordController from '../../../ims/api/infrastructure/express/controllers/authentication/UpdatePasswordController';
import RegisterController from '../../../ims/api/infrastructure/express/controllers/authentication/RegisterController';

export const register = function (app: Express): void {
  const container = new Container().invoke();
  const authenticationController: AuthenticationController =
    container.resolve<AuthenticationController>('authenticationController');
  const updatePasswordController: UpdatePasswordController =
    container.resolve<UpdatePasswordController>('updatePasswordController');
  const registerController: RegisterController = container.resolve<RegisterController>('registerController');

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

  app.post('/auth/register', registerController.rules, registerController.invoke.bind(registerController));
};
