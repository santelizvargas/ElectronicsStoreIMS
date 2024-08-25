import { EnableUserRequest, EnableUserResponse } from '../../../application/authentication/EnableUserService';
import { Enabler } from '../../../domain/authentication/Enabler';
import { AuthenticationRepository } from '../../../domain/models/authentication/repositories/AuthenticationRepository';

export default class ClientEnabler implements Enabler {
  constructor(private authenticationRepository: AuthenticationRepository) {}

  public async invoke(request: EnableUserRequest): Promise<EnableUserResponse> {
    await this.authenticationRepository.enable(request.id);
    return {
      message: 'User enable',
      code: 200,
    };
  }
}
