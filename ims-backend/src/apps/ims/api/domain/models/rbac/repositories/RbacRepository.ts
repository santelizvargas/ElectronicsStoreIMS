import { Role } from '@prisma/client';

export interface RbacRepository {
  assignRole(email: string, role: string): Promise<Role>;
}
