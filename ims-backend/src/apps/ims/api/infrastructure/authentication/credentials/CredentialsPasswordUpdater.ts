import httpStatus from 'http-status';
import {
  UpdatePasswordRequest,
  UpdatePasswordResponse,
} from '../../../application/authentication/UpdatePasswordService';
import { PasswordUpdater } from '../../../domain/authentication/PasswordUpdater';
import { AuthenticationRepository } from '../../../domain/models/authentication/repositories/AuthenticationRepository';
import { User } from '../../../domain/models/authentication/User';

export default class CredentialsPasswordUpdater implements PasswordUpdater {
  constructor(private readonly authenticationRepository: AuthenticationRepository) {}

  public async invoke(request: UpdatePasswordRequest): Promise<UpdatePasswordResponse> {
    const foundUser: User | null = await this.authenticationRepository.findByCredentials(
      request.email,
      request.currentPassword,
    );

    // Check if user exists, if not throw error
    if (!foundUser) {
      throw new Error('User not found');
    }

    // Check if passwords match
    if (request.password !== request.confirmPassword) {
      throw new Error('Passwords do not match');
    }

    // Ignore password field from response
    const { password: _, ...user }: User = await this.authenticationRepository.updatePassword(
      request.email,
      request.password,
    );
    return {
      message: 'Password updated',
      code: httpStatus.OK,
      data: user,
    };
  }
}
