import type { Request, Response, NextFunction } from 'express';
import status from 'http-status';
import { Controller } from '../../../../../shared/infrastructure/express/controllers/Controller';
import { ErrorHandler } from '../../../../../shared/domain/ErrorHandler';
import { body } from 'express-validator';
import { RequestValidator } from '../../../../../shared/infrastructure/express/RequestValidator';
import AssignRoleService, { AssignRoleResponse } from '../../../../application/rbac/AssignRoleService';

export default class AssignRoleController implements Controller {
  public readonly rules = [
    body('email').trim().normalizeEmail().isEmail().withMessage('Please give a valid email'),
    body('role').exists().trim().isString().withMessage('Please give a valid role'),
    RequestValidator,
  ];

  constructor(private assignRoleService: AssignRoleService) {}

  async invoke(request: Request, response: Response, next: NextFunction): Promise<Response | void> {
    try {
      const rbacResponse: AssignRoleResponse = await this.assignRoleService.invoke({
        ...request.body,
      });

      response.json(rbacResponse).status(status.OK);
    } catch (error) {
      const { message } = error as Error;
      const errorHandler = new ErrorHandler(message, status.INTERNAL_SERVER_ERROR);
      next(response.json(errorHandler.toJson()));
    }
  }
}
