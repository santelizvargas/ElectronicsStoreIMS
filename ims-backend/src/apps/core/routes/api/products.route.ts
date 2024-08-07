import { Express } from 'express';
import Container from '../../di/Container';
import CreateProductController from '../../../ims/api/infrastructure/express/controllers/products/CreateProductController';

export const register = function (app: Express): void {
  const controller: CreateProductController = new Container()
    .invoke()
    .resolve<CreateProductController>('createProductController');
  app.post('/products', controller.rules, controller.invoke.bind(controller));
};
