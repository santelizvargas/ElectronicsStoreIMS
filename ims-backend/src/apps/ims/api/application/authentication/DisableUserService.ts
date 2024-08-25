import { Logger } from '../../../shared/domain/Logger';
import { Remover } from '../../../shared/domain/Remover';

export type DisableUserRequest = {
  id: number;
};

export type DisableUserResponse = {
  message: string;
  code: number;
};

export default class DisableUserService {
  constructor(
    private logger: Logger,
    private removerUser: Remover<DisableUserRequest, DisableUserResponse>,
  ) {}

  public async invoke(request: DisableUserRequest): Promise<DisableUserResponse> {
    this.logger.info(`User disable attempt using id: ${request.id}`);
    return this.removerUser.invoke(request);
  }
}
