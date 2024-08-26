import { PrismaClient, Role } from '@prisma/client';
import { AuthenticationRepository } from '../../../domain/models/authentication/repositories/AuthenticationRepository';
import { User } from '../../../domain/models/authentication/User';
import { OmittedUser } from '../../../application/authentication/RegistrationService';

export default class PrismaAuthenticationRepository implements AuthenticationRepository {
  constructor(private database: PrismaClient) {}

  public async create(data: OmittedUser): Promise<User & { roles: Role[] }> {
    const defaultRole = await this.database.role.findFirst({
      where: {
        name: 'Vendedor',
      },
    });
    const user = await this.database.user.create({
      relationLoadStrategy: 'join',
      include: {
        roles: {
          select: {
            role: true,
          },
        },
      },
      data: {
        ...data,
        createdAt: new Date(),
        updatedAt: new Date(),
        roles: {
          create: {
            roleId: defaultRole?.id || 0,
          },
        },
      },
    });

    return {
      ...user,
      roles: user.roles.map(({ role }) => role),
    };
  }

  public async findAll(): Promise<Omit<User, 'password'>[]> {
    const users = await this.database.user.findMany({
      relationLoadStrategy: 'join',
      include: {
        roles: {
          select: {
            role: true,
          },
        },
      },
      omit: {
        password: true,
      },
    });

    return users.map((user) => ({
      ...user,
      roles: user.roles.map(({ role }) => role),
    }));
  }

  public async findByCredentials(email: string, password: string): Promise<User | null> {
    return await this.database.user.findFirst({
      relationLoadStrategy: 'join',
      include: {
        roles: {
          select: {
            role: true,
          },
        },
      },
      where: {
        email,
        password,
        deletedAt: null,
      },
    });
  }

  public async updatePassword(email: string, password: string): Promise<User> {
    return await this.database.user.update({
      relationLoadStrategy: 'join',
      include: {
        roles: {
          select: {
            role: true,
          },
        },
      },
      where: {
        email,
      },
      data: {
        password,
      },
    });
  }

  public async enable(id: number): Promise<void> {
    await this.database.user.update({
      where: {
        id,
      },
      data: {
        deletedAt: null,
      },
    });
  }

  public async disable(id: number): Promise<void> {
    await this.database.user.update({
      where: {
        id,
      },
      data: {
        deletedAt: new Date(),
      },
    });
  }
}
