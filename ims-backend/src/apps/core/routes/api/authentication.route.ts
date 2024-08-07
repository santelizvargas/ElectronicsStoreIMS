import { Express } from 'express';
import AuthenticationController from '../../../ims/api/infrastructure/express/controllers/AuthenticationController';
import Container from '../../di/Container';

export const register = function (app: Express): void {
  const controller: AuthenticationController = new Container()
    .invoke()
    .resolve<AuthenticationController>('authenticationController');
  app.post('/auth/login', controller.rules, controller.invoke.bind(controller));
};
