import { OmittedUser } from '../../../../application/authentication/RegistrationService';
import { User } from '../User';

export interface AuthenticationRepository {
  create(data: OmittedUser): Promise<User>;
  findAll(): Promise<Omit<User, 'password'>[]>;
  findByCredentials(email: string, password: string): Promise<User | null>;
  updatePassword(email: string, password: string): Promise<User>;
  enable(id: number): Promise<void>;
  disable(id: number): Promise<void>;
}
