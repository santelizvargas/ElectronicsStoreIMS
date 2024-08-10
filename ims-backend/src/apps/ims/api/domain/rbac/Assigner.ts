import { AssignRoleRequest, AssignRoleResponse } from '../../application/rbac/AssignRoleService';

export interface Assigner {
  invoke(request: AssignRoleRequest): Promise<AssignRoleResponse>;
}
