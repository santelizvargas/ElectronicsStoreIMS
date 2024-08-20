import { RegistrationRequest, RegistrationResponse } from '../../application/authentication/RegistrationService';

export interface Register {
  invoke(request: RegistrationRequest): Promise<RegistrationResponse>;
}
