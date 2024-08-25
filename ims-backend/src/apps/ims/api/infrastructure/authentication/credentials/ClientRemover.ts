import { Remover } from '../../../../shared/domain/Remover';
import { DisableUserRequest, DisableUserResponse } from '../../../application/authentication/DisableUserService';
import { AuthenticationRepository } from '../../../domain/models/authentication/repositories/AuthenticationRepository';

export default class ClientRemover implements Remover<DisableUserRequest, DisableUserResponse> {
  constructor(private authenticationRepository: AuthenticationRepository) {}

  public async invoke(request: DisableUserRequest): Promise<DisableUserResponse> {
    await this.authenticationRepository.disable(request.id);
    return {
      message: 'User disabled',
      code: 200,
    };
  }
}
