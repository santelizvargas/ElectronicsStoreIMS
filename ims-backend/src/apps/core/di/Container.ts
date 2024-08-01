import { createContainer, asFunction, AwilixContainer, InjectionMode, asClass } from 'awilix';
import { createPrismaClient } from '../../ims/shared/infrastructure/persistence/prisma';
import WinstonLogger from '../../ims/shared/infrastructure/logger/WinstonLogger';
import CredentialsAuthenticator from '../../ims/api/infrastructure/authentication/credentials/CredentialsAuthenticator';
import JWTConfig from '../../ims/api/application/tokens/JWTConfig';
import PrismaAuthenticationRepository from '../../ims/api/infrastructure/authentication/repositories/PrismaAuthenticationRepository';
import AuthenticationService from '../../ims/api/application/authentication/AuthenticationService';
import AuthenticationController from '../../ims/api/infrastructure/express/controllers/AuthenticationController';
import CredentialsClient from '../../ims/api/infrastructure/authentication/credentials/CredentialsClient';
import JWTManager from '../../ims/api/application/tokens/JWTManager';

export default class Container {
  private readonly container: AwilixContainer;

  constructor() {
    this.container = createContainer({
      injectionMode: InjectionMode.CLASSIC,
    });

    this.register();
  }

  public register(): void {
    this.container.register({
      logger: asClass(WinstonLogger).singleton(),
      database: asFunction(createPrismaClient).singleton(),
      authenticator: asClass(CredentialsAuthenticator).singleton(),
      client: asClass(CredentialsClient).singleton(),
      jwtConfig: asClass(JWTConfig).singleton(),
      jwtManager: asClass(JWTManager).singleton(),
      authenticationRepository: asClass(PrismaAuthenticationRepository).singleton(),
      authenticationService: asClass(AuthenticationService).singleton(),
      authenticationController: asClass(AuthenticationController).singleton(),
    });
  }

  public invoke(): AwilixContainer {
    return this.container;
  }
}
