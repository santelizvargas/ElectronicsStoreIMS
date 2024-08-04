import { Logger } from '../../../shared/domain/Logger';
import { Authenticator } from '../../domain/authentication/Authenticator';

export type AuthenticationRequest = {
  email: string;
  password: string;
};

export type AuthenticationResponse = {
  accessToken: string;
  expiresIn: number | string;
};

export default class AuthenticationService {
  constructor(
    private logger: Logger,
    private authenticator: Authenticator,
  ) {}

  public async invoke(request: AuthenticationRequest): Promise<AuthenticationResponse> {
    this.logger.info(`User authentication attempt using email: ${request.email}`);
    return this.authenticator.auth(request);
  }
}