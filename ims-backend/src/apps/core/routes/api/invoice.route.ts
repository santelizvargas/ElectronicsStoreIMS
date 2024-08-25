import { Express } from 'express';
import Container from '../../di/Container';
import CreateInvoiceController from '../../../ims/api/infrastructure/express/controllers/invoices/CreateInvoiceController';
import FetchInvoiceController from '../../../ims/api/infrastructure/express/controllers/invoices/FetchInvoiceController';

export const register = function (app: Express): void {
  const container = new Container().invoke();
  const createController: CreateInvoiceController =
    container.resolve<CreateInvoiceController>('createInvoiceController');
  const fetchController: FetchInvoiceController = container.resolve<FetchInvoiceController>('fetchInvoiceController');

  app.get('/invoices', fetchController.invoke.bind(fetchController));
  app.post('/invoices', createController.rules, createController.invoke.bind(createController));
};
