import { Express } from 'express';
import Container from '../../di/Container';
import CreateProductController from '../../../ims/api/infrastructure/express/controllers/products/CreateProductController';
import FetchProductController from '../../../ims/api/infrastructure/express/controllers/products/FetchProductController';
import RemoveProductController from '../../../ims/api/infrastructure/express/controllers/products/RemoveProductController';
import SupplyProductController from '../../../ims/api/infrastructure/express/controllers/products/SupplyProductController';
import CountProductController from '../../../ims/api/infrastructure/express/controllers/products/CountProductController';
import multer, { fileHandler } from '../../middlewares/multer';

export const register = function (app: Express): void {
  const container = new Container().invoke();
  const fetchController: FetchProductController = container.resolve<FetchProductController>('fetchProductController');
  const createController: CreateProductController =
    container.resolve<CreateProductController>('createProductController');
  const removeController: RemoveProductController =
    container.resolve<RemoveProductController>('removeProductController');
  const supplyController: SupplyProductController =
    container.resolve<SupplyProductController>('supplyProductController');
  const countController: CountProductController = container.resolve<CountProductController>('countProductController');

  app.get('/products', fetchController.invoke.bind(fetchController));
  app.get('/products/count', countController.invoke.bind(countController));
  app.post('/products', multer.array('images'), fileHandler, createController.invoke.bind(createController));
  app.put('/products', supplyController.rules, supplyController.invoke.bind(supplyController));
  app.delete('/products', removeController.rules, removeController.invoke.bind(removeController));
};
