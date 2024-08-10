import { PrismaClient, Role } from '@prisma/client';
import { RbacRepository } from '../../../domain/models/rbac/repositories/RbacRepository';

export default class PrismaRbacRepository implements RbacRepository {
  constructor(private readonly database: PrismaClient) {}

  public async assignRole(email: string, role: string): Promise<Role> {
    return await this.database.role.update({
      where: {
        name: role,
      },
      data: {
        roles: {
          create: [
            {
              user: {
                connect: {
                  email,
                },
              },
            },
          ],
        },
      },
    });
  }
}
