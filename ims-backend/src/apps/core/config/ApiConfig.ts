export default class ApiConfig {
  public readonly prefix: string;
  public readonly version: string;

  constructor(prefix: string = '/api', version: string = 'v1') {
    this.prefix = process.env.API_PREFIX || prefix;
    this.version = process.env.API_VERSION || version;
  }

  route(): string {
    return `${this.prefix}/${this.version}`;
  }
}
