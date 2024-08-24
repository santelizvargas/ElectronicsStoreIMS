export default class AWSConfig {
  public readonly bucket: string;
  public readonly region: string;

  constructor() {
    this.bucket = process.env.S3_BUCKET_NAME || '';
    this.region = process.env.S3_REGION || '';
  }

  accessKey(): string {
    return process.env.S3_ACCESS_KEY || '';
  }

  secretKey(): string {
    return process.env.S3_ACCESS_SECRET || '';
  }
}
