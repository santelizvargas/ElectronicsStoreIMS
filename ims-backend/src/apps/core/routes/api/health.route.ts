import { Express } from 'express';
import { HealthController } from '../../controllers/Api/HealthController';
import { Controller } from '../../controllers/Controller';

export const register = function (app: Express): void {
  const healthController: Controller = new HealthController();
  app.get('/health', healthController.run.bind(healthController));
};
