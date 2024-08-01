import express from 'express';
import http, { createServer } from 'http';
import AppRouter from './routes/AppRouter';
import ApiConfig from './config/ApiConfig';

export default class Server {
  private readonly app: express.Express;
  private readonly baseURL: string;
  private readonly port: string | number;
  private readonly api: ApiConfig;
  private readonly httpServer: http.Server;
  private readonly router: AppRouter;

  constructor(baseURL: string, port: string | number, api: ApiConfig) {
    this.baseURL = baseURL;
    this.port = port;
    this.api = api;
    this.app = express();
    this.router = new AppRouter();
    this.httpServer = createServer(this.app);
    this.app.use(this.api.route(), this.router.getRouter());
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
}
