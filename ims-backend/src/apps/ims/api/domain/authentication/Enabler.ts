import { EnableUserRequest, EnableUserResponse } from '../../application/authentication/EnableUserService';

export interface Enabler {
  invoke(request: EnableUserRequest): Promise<EnableUserResponse>;
}
