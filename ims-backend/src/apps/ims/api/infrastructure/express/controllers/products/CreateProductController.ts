import { NextFunction, Request, Response } from 'express';
import { body } from 'express-validator';
import status from 'http-status';
import { Controller } from '../../../../../shared/infrastructure/express/controllers/Controller';
import { RequestValidator } from '../../../../../shared/infrastructure/express/RequestValidator';
import CreateProductService, {
  ProductRequest,
  ProductResponse,
} from '../../../../application/products/CreateProductService';
import { ErrorHandler } from '../../../../../shared/domain/ErrorHandler';
import { AWSFileUploader } from '../../../../../../core/utils/AWSUploaderFile';
import { File, UploadedFile } from '../../../../../../core/middlewares/multer';

export default class CreateProductController implements Controller {
  public readonly rules = [
    body('name').trim().isString().withMessage('Please give a valid name'),
    body('description').optional().trim().isString().withMessage('Please give a valid description'),
    body('salePrice').isString().withMessage('Please give a valid sale price'),
    body('purchasePrice').isString().withMessage('Please give a valid purchase price'),
    body('stock').isString().withMessage('Please give a valid stock'),
    body('category').isString().withMessage('Please give a valid category'),
    body('images').isArray().withMessage('Please give a valid images'),
    RequestValidator,
  ];

  constructor(
    private readonly createProductService: CreateProductService,
    private readonly imageUploader: AWSFileUploader,
  ) {}

  async invoke(request: Request, response: Response, next: NextFunction): Promise<Response | void> {
    try {
      // @ts-ignore
      const imagePaths: UploadedFile[] = await this.imageUploader.upload(request.body.files as File[]);
      const productData = {
        name: request.body.name,
        description: request.body.description,
        salePrice: parseFloat(request.body.salePrice),
        purchasePrice: parseFloat(request.body.purchasePrice),
        stock: parseInt(request.body.stock),
        category: request.body.category,
        images: imagePaths.map((image) => image.path),
      } as ProductRequest;
      const productResponse: ProductResponse = await this.createProductService.create(productData);

      return response.json(productResponse).status(status.CREATED);
    } catch (error) {
      const { message } = error as Error;
      const errorHandler = new ErrorHandler(message, status.INTERNAL_SERVER_ERROR);
      next(response.json(errorHandler.toJson()));
    }
  }
}
