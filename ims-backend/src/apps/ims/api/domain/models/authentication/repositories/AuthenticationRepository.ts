import { User } from '../User';

export interface AuthenticationRepository {
  findByCredentials(email: string, password: string): Promise<User | null>;
}