import { UpdatePasswordRequest, UpdatePasswordResponse } from '../../application/authentication/UpdatePasswordService';

export interface PasswordUpdater {
  invoke(request: UpdatePasswordRequest): Promise<UpdatePasswordResponse>;
}
