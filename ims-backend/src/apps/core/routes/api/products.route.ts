import { Express } from 'express';
import Container from '../../di/Container';
import CreateProductController from '../../../ims/api/infrastructure/express/controllers/products/CreateProductController';
import FetchProductController from '../../../ims/api/infrastructure/express/controllers/products/FetchProductController';

export const register = function (app: Express): void {
  const container = new Container().invoke();
  const fetchController: FetchProductController = container.resolve<FetchProductController>('fetchProductController');
  const createController: CreateProductController =
    container.resolve<CreateProductController>('createProductController');

  app.get('/products', fetchController.rules, fetchController.invoke.bind(fetchController));
  app.post('/products', createController.rules, createController.invoke.bind(createController));
};
