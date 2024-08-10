import httpStatus from 'http-status';
import { AssignRoleRequest, AssignRoleResponse } from '../../application/rbac/AssignRoleService';
import { RbacRepository } from '../../domain/models/rbac/repositories/RbacRepository';
import { Assigner } from '../../domain/rbac/Assigner';

export default class RoleAssigner implements Assigner {
  public constructor(private readonly rbacRepository: RbacRepository) {}

  public async invoke(request: AssignRoleRequest): Promise<AssignRoleResponse> {
    await this.rbacRepository.assignRole(request.email, request.role);
    return {
      message: `Role ${request.role} assigned to user ${request.email}`,
      code: httpStatus.OK,
    };
  }
}
