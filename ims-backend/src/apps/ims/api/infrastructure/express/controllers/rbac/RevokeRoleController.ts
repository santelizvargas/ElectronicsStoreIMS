import type { Request, Response, NextFunction } from 'express';
import status from 'http-status';
import { Controller } from '../../../../../shared/infrastructure/express/controllers/Controller';
import { ErrorHandler } from '../../../../../shared/domain/ErrorHandler';
import { body } from 'express-validator';
import { RequestValidator } from '../../../../../shared/infrastructure/express/RequestValidator';
import { RbacRepository } from '../../../../domain/models/rbac/repositories/RbacRepository';

export default class RevokeRoleController implements Controller {
  public readonly rules = [
    body('email').trim().normalizeEmail().isEmail().withMessage('Please give a valid email'),
    body('roleId').exists().isNumeric().withMessage('Please give a valid role id'),
    RequestValidator,
  ];

  constructor(private readonly rbacRepository: RbacRepository) {}

  async invoke(request: Request, response: Response, next: NextFunction): Promise<Response | void> {
    try {
      await this.rbacRepository.revokeRole(request.body.email, request.body.roleId);
      const rbacResponse = {
        message: 'Role revoked successfully',
      };
      response.json(rbacResponse).status(status.OK);
    } catch (error) {
      const { message } = error as Error;
      const errorHandler = new ErrorHandler(message, status.INTERNAL_SERVER_ERROR);
      next(response.json(errorHandler.toJson()));
    }
  }
}
