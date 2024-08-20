import { Fetcher } from '../../../../shared/domain/Fetcher';
import { FetchResponse } from '../../../application/authentication/FetchAuthenticationService';
import { AuthenticationRepository } from '../../../domain/models/authentication/repositories/AuthenticationRepository';

export default class ClientFetcher implements Fetcher<FetchResponse> {
  constructor(private authenticationRepository: AuthenticationRepository) {}

  public async invoke(): Promise<FetchResponse> {
    const users = await this.authenticationRepository.findAll();
    return { data: users };
  }
}
