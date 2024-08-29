export default class DatabaseConfig {
  public readonly url: string;

  constructor() {
    this.url = String(process.env.DATABASE_URL);
  }
}
