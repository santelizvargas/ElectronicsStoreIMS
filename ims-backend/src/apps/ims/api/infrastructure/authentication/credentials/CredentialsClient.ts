import { User } from '../../../domain/models/authentication/User';
import { AuthenticationRepository } from '../../../domain/models/authentication/repositories/AuthenticationRepository';

export default class CredentialsClient {
  constructor(private authenticationRepository: AuthenticationRepository) {}

  public async authenticator(email: string, password: string): Promise<User | null> {
    return await this.authenticationRepository.findByCredentials(email, password);
  }
}
