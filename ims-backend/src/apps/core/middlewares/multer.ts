import { Request, Response, NextFunction } from 'express';
import multer from 'multer';
export interface File {
  name: string;
  size: number;
  type: string;
  extension: string;
  content: ArrayBuffer;
}

export interface UploadedFile {
  path: string;
}

export interface FileUploader {
  upload: (files: File | File[]) => Promise<UploadedFile[] | undefined>;
}

export default multer();

export const fileHandler = (req: Request, _: Response, next: NextFunction) => {
  const { files } = req;

  const mappedFiles: File[] = ((files as Express.Multer.File[]) || []).map(function (file) {
    const [name, extension] = file.originalname.split('.');
    return {
      name,
      type: file.mimetype,
      content: file.buffer,
      size: file.size,
      extension: extension || '',
    };
  });

  Object.assign(req.body, { files: mappedFiles });
  return next();
};
