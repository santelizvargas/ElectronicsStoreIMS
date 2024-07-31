import express from 'express';
import helmet from 'helmet';
import http, { createServer } from 'http';
import compress from 'compression';
import AppRouter from './routes/AppRouter';
import ApiConfig from './config/ApiConfig';

export default class Server {
  private readonly app: express.Express;
  private readonly baseURL: string;
  private readonly port: string | number;
  private readonly api: ApiConfig;
  private readonly httpServer: http.Server;

  constructor(baseURL: string, port: string | number, api: ApiConfig) {
    this.baseURL = baseURL;
    this.port = port;
    this.api = api;
    this.app = express();
    this.configureApp();
    this.httpServer = createServer(this.app);
  }

  async start(): Promise<void> {
    await this.listen();
  }

  async listen(): Promise<void> {
    return new Promise((resolve) => {
      const environment = this.app.get('env');
      this.httpServer.listen(this.port, () => {
        console.info(`App is running at ${this.baseURL}:${this.port} in ${environment} mode`);
        console.info('Press CTRL-C to stop\n');
        resolve();
      });
    });
  }

  async stop(): Promise<void> {
    return new Promise((resolve, reject) => {
      this.httpServer.close((error) => {
        if (error) {
          return reject(error);
        }

        return resolve();
      });
    });
  }

  private configureApp(): void {
    const router = new AppRouter().getRouter();
    this.app.use(express.json());
    this.app.use(express.urlencoded({ extended: true }));
    this.app.use(helmet.xssFilter());
    this.app.use(helmet.noSniff());
    this.app.use(helmet.hidePoweredBy());
    this.app.use(helmet.frameguard({ action: 'deny' }));
    this.app.use(compress());
    this.app.use(this.api.route(), router);
  }
}
