import { Logger } from '../../../shared/domain/Logger';
import { PasswordUpdater } from '../../domain/authentication/PasswordUpdater';
import { User } from '../../domain/models/authentication/User';

export type UpdatePasswordRequest = {
  email: string;
  currentPassword: string;
  password: string;
  confirmPassword: string;
};

export type UpdatePasswordResponse = {
  message: string;
  code: number;
  data: Omit<User, 'password'>;
};

export default class UpdatePasswordService {
  constructor(
    private logger: Logger,
    private passwordUpdater: PasswordUpdater,
  ) {}

  public async invoke(request: UpdatePasswordRequest): Promise<UpdatePasswordResponse> {
    this.logger.info(`User password update attempt using email: ${request.email}`);
    return this.passwordUpdater.invoke(request);
  }
}
