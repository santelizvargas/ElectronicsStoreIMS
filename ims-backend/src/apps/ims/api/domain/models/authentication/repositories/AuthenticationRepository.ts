import { OmittedUser } from '../../../../application/authentication/RegistrationService';
import { User } from '../User';

export interface AuthenticationRepository {
  create(data: OmittedUser): Promise<User>;
  findByCredentials(email: string, password: string): Promise<User | null>;
  updatePassword(email: string, password: string): Promise<User>;
}
