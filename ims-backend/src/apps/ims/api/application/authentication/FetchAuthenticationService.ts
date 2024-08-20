import { Logger } from '../../../shared/domain/Logger';
import { User } from '../../domain/models/authentication/User';
import { Fetcher } from '../../../shared/domain/Fetcher';

export type FetchResponse = {
  data: Omit<User, 'password'>[];
};

export default class FetchAuthenticationService {
  constructor(
    private readonly logger: Logger,
    private readonly authenticationFetcher: Fetcher<FetchResponse>,
  ) {}

  public async invoke(): Promise<FetchResponse> {
    this.logger.info(`User fetch attempt`);
    return this.authenticationFetcher.invoke();
  }
}
