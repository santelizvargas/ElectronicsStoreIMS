import { PrismaClient } from '@prisma/client';
import { AuthenticationRepository } from '../../../domain/models/authentication/repositories/AuthenticationRepository';
import { User } from '../../../domain/models/authentication/User';

export default class PrismaAuthenticationRepository implements AuthenticationRepository {
  constructor(private database: PrismaClient) {}

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
