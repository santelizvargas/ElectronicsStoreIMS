import {
  AuthenticationRequest,
  AuthenticationResponse,
} from '../../../application/authentication/AuthenticationService';
import JWTManager from '../../../application/tokens/JWTManager';
import { Authenticator } from '../../../domain/authentication/Authenticator';
import { User } from '../../../domain/models/authentication/User';
import CredentialsClient from './CredentialsClient';

export default class CredentialsAuthenticator implements Authenticator {
  constructor(
    private client: CredentialsClient,
    private jwtManager: JWTManager,
  ) {}

  public async auth(request: AuthenticationRequest): Promise<AuthenticationResponse> {
    const user: User | null = await this.client.authenticator(request.email, request.password);

    if (!user) {
      throw new Error('Wrong credentials');
    }

    // Ignore password field
    const { password: _, ...userData } = user;
    const { accessToken, expiresIn }: Omit<AuthenticationResponse, 'data'> = this.jwtManager.generate(userData);
    return {
      accessToken,
      expiresIn,
      data: userData,
    };
  }
}
