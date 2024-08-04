import { AuthenticationRequest, AuthenticationResponse } from '../../application/authentication/AuthenticationService';

export interface Authenticator {
  auth(t: AuthenticationRequest): Promise<AuthenticationResponse>;
}
