import { Request, Response, NextFunction, Router } from 'express';
import cors from 'cors';
import httpStatus from 'http-status';
import { sync } from 'glob';
import compress from 'compression';
import helmet from 'helmet';
import express from 'express';

export default class AppRouter {
  private readonly router: Router;

  constructor() {
    this.router = Router();
    this.router.use(cors());

    this.router.use((error: Error, _req: Request, res: Response, _next: NextFunction) => {
      console.error(error);
      res.status(httpStatus.INTERNAL_SERVER_ERROR).send(error.message);
    });

    this.router.use(express.json());
    this.router.use(express.urlencoded({ extended: true }));
    this.router.use(helmet.xssFilter());
    this.router.use(helmet.noSniff());
    this.router.use(helmet.hidePoweredBy());
    this.router.use(helmet.frameguard({ action: 'deny' }));
    this.router.use(compress());

    this.registerRoutes();
  }

  getRouter(): Router {
    return this.router;
  }

  private registerRoutes(): void {
    const routes = sync(`${__dirname}/**/*.route.*`);
    routes.forEach((route) => this.register(route));
  }

  private register(path: string): void {
    const route = require(path);
    route.register(this.router);
  }
}
