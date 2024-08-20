import { Register } from '../../domain/authentication/Register';
import { Logger } from '../../../shared/domain/Logger';
import { User } from '../../domain/models/authentication/User';

export type OmittedUser = Omit<User, 'id' | 'createdAt' | 'updatedAt' | 'deletedAt'>;
export type RegistrationRequest = OmittedUser & {
  confirmPassword: string;
};

export type RegistrationResponse = {
  accessToken: string;
  expiresIn: number | string;
  data: Omit<User, 'password'>;
};

export default class RegistrationService {
  constructor(
    private readonly logger: Logger,
    private readonly register: Register,
  ) {}

  public async invoke(request: RegistrationRequest): Promise<RegistrationResponse> {
    this.logger.info(`User registration attempt using email: ${request.email}`);
    return this.register.invoke(request);
  }
}
