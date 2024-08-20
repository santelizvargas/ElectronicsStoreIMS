import { PrismaClient } from '@prisma/client';
import { AuthenticationRepository } from '../../../domain/models/authentication/repositories/AuthenticationRepository';
import { User } from '../../../domain/models/authentication/User';
import { OmittedUser } from '../../../application/authentication/RegistrationService';

export default class PrismaAuthenticationRepository implements AuthenticationRepository {
  constructor(private database: PrismaClient) {}

  public async create(data: OmittedUser): Promise<User> {
    return await this.database.user.create({
      data: {
        ...data,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
    });
  }

  public async findAll(): Promise<Omit<User, 'password'>[]> {
    return await this.database.user.findMany({
      omit: {
        password: true,
      },
    });
  }

  public async findByCredentials(email: string, password: string): Promise<User | null> {
    return await this.database.user.findFirst({
      where: {
        email,
        password,
      },
    });
  }

  public async updatePassword(email: string, password: string): Promise<User> {
    return await this.database.user.update({
      where: {
        email,
      },
      data: {
        password,
      },
    });
  }
}
