import { Logger } from '../../../shared/domain/Logger';
import { Enabler } from '../../domain/authentication/Enabler';

export type EnableUserRequest = {
  id: number;
};

export type EnableUserResponse = {
  message: string;
  code: number;
};

export default class EnableUserService {
  constructor(
    private logger: Logger,
    private enableUser: Enabler,
  ) {}

  public async invoke(request: EnableUserRequest): Promise<EnableUserResponse> {
    this.logger.info(`User enable attempt using id: ${request.id}`);
    return this.enableUser.invoke(request);
  }
}
