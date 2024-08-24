import { S3 } from 'aws-sdk';
import { File, FileUploader, UploadedFile } from '../middlewares/multer';
import AWSConfig from '../config/AWSConfig';

export class AWSFileUploader implements FileUploader {
  private client: S3;
  private readonly bucketName: string;
  private readonly bucketURL: string;

  constructor() {
    const awsConfig = new AWSConfig();
    this.bucketName = awsConfig.bucket;
    this.bucketURL = `https://${this.bucketName}.s3.${awsConfig.region}.amazonaws.com`;
    this.client = new S3({
      credentials: {
        accessKeyId: awsConfig.accessKey(),
        secretAccessKey: awsConfig.secretKey(),
      },
      region: awsConfig.region,
    });
  }

  private generateFileKey(file: File, timestamp: number): string {
    return `${file.name}-${timestamp}.${file.extension}`;
  }

  private async uploadFile(file: File): Promise<string> {
    const timestamp = Date.now();
    const fileKey = this.generateFileKey(file, timestamp);
    await this.client
      .putObject({
        Bucket: this.bucketName,
        Key: fileKey,
        ContentType: file.type,
        Body: file.content,
      })
      .promise();

    return `${this.bucketURL}/${fileKey}`;
  }

  async upload(files: File | File[]): Promise<UploadedFile[] | undefined> {
    try {
      if (Array.isArray(files)) {
        const paths = await Promise.all(files.map(async (file) => this.uploadFile(file)));
        return paths.map((path) => ({ path }));
      }

      const path = await this.uploadFile(files);
      return [
        {
          path,
        },
      ];
    } catch {
      return undefined;
    }
  }
}
