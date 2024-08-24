import multer from 'multer';
import multerS3 from 'multer-s3';
import AWSConfig from '../config/AWSConfig';
import { S3Client } from '@aws-sdk/client-s3';

const awsConfig = new AWSConfig();
const s3 = new S3Client({
  credentials: {
    accessKeyId: awsConfig.accessKey(),
    secretAccessKey: awsConfig.secretKey(),
  },
  region: awsConfig.region,
});

export default multer({
  storage: multerS3({
    s3,
    bucket: awsConfig.bucket,
  }),
});
