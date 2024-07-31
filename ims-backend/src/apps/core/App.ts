import { config } from 'dotenv';
import Server from './Server';
import ApiConfig from './config/ApiConfig';

export default class App {
  private readonly server: Server;

  constructor() {
    // Load env variables
    config();

    // Configure server variables
    const baseURL = process.env.BASE_URL || '0.0.0.0';
    const port = process.env.PORT || '8080';
    const apiConfig = new ApiConfig();

    // Configure the server instance
    this.server = new Server(baseURL, port, apiConfig);
  }

  async start(): Promise<void> {
    return await this.server.start();
  }

  async stop(): Promise<void> {
    return await this.server.stop();
  }
}
