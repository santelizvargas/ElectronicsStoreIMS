import { Express } from 'express';
import Container from '../../di/Container';
import CreateProductController from '../../../ims/api/infrastructure/express/controllers/products/CreateProductController';
import FetchProductController from '../../../ims/api/infrastructure/express/controllers/products/FetchProductController';
import RemoveProductController from '../../../ims/api/infrastructure/express/controllers/products/RemoveProductController';

export const register = function (app: Express): void {
  const container = new Container().invoke();
  const fetchController: FetchProductController = container.resolve<FetchProductController>('fetchProductController');
  const createController: CreateProductController =
    container.resolve<CreateProductController>('createProductController');
  const removeController: RemoveProductController =
    container.resolve<RemoveProductController>('removeProductController');

  app.get('/products', fetchController.invoke.bind(fetchController));
  app.post('/products', createController.rules, createController.invoke.bind(createController));
  app.delete('/products', removeController.rules, removeController.invoke.bind(removeController));
};
