import { RegistrationRequest, RegistrationResponse } from '../../../application/authentication/RegistrationService';
import JWTManager from '../../../application/tokens/JWTManager';
import { Register } from '../../../domain/authentication/Register';
import { AuthenticationRepository } from '../../../domain/models/authentication/repositories/AuthenticationRepository';
import { User } from '../../../domain/models/authentication/User';

export default class CredentialsClientRegister implements Register {
  constructor(
    private authenticationRepository: AuthenticationRepository,
    private jwtManager: JWTManager,
  ) {}

  public async invoke(request: RegistrationRequest): Promise<RegistrationResponse> {
    // Check if passwords matchs
    if (request.password !== request.confirmPassword) {
      throw new Error('Passwords do not match');
    }

    // Ignore confirmPassword field
    const { confirmPassword, ...cleanRequest } = request;
    const user: User = await this.authenticationRepository.create(cleanRequest);

    // Ignore password field
    const { password: _, ...userData } = user;
    const { accessToken, expiresIn }: Omit<RegistrationResponse, 'data'> = this.jwtManager.generate(userData);
    return {
      accessToken,
      expiresIn,
      data: userData,
    };
  }
}
