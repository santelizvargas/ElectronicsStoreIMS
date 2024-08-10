import { Assigner } from '../../domain/rbac/Assigner';

export type AssignRoleRequest = {
  email: string;
  role: string;
};

export type AssignRoleResponse = {
  message: string;
  code: number;
};

export default class AssignRoleService {
  constructor(private readonly roleAssigner: Assigner) {}

  public async invoke(request: AssignRoleRequest): Promise<AssignRoleResponse> {
    return await this.roleAssigner.invoke(request);
  }
}
