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
import CreateProductService from '../../ims/api/application/products/CreateProductService';
import ProductCreator from '../../ims/api/infrastructure/products/ProductCreator';
import PrismaProductRepository from '../../ims/api/infrastructure/products/repositories/PrismaProductRepository';
import CreateProductController from '../../ims/api/infrastructure/express/controllers/products/CreateProductController';
import ProductFetcher from '../../ims/api/infrastructure/products/ProductFetcher';
import FetchProductService from '../../ims/api/application/products/FetchProductService';
import FetchProductController from '../../ims/api/infrastructure/express/controllers/products/FetchProductController';
import RemoveProductService from '../../ims/api/application/products/RemoveProductService';
import ProductRemover from '../../ims/api/infrastructure/products/ProductRemover';
import RemoveProductController from '../../ims/api/infrastructure/express/controllers/products/RemoveProductController';
import SupplyProductController from '../../ims/api/infrastructure/express/controllers/products/SupplyProductController';
import ProductSupplier from '../../ims/api/infrastructure/products/ProductSupplier';
import SupplyProductService from '../../ims/api/application/products/SupplyProductService';

export default class Container {
  private readonly container: AwilixContainer;

  constructor() {
    this.container = createContainer({
      injectionMode: InjectionMode.CLASSIC,
    });

    this.register();
  }

  public register(): void {
    this.container
      .register({
        logger: asClass(WinstonLogger).singleton(),
        database: asFunction(createPrismaClient).singleton(),
      })
      .register({
        authenticator: asClass(CredentialsAuthenticator).singleton(),
        client: asClass(CredentialsClient).singleton(),
      })
      .register({
        jwtConfig: asClass(JWTConfig).singleton(),
        jwtManager: asClass(JWTManager).singleton(),
      })
      .register({
        authenticationRepository: asClass(PrismaAuthenticationRepository).singleton(),
        authenticationService: asClass(AuthenticationService).singleton(),
        authenticationController: asClass(AuthenticationController).singleton(),
      })
      .register({
        createProductService: asClass(CreateProductService).singleton(),
        fetchProductService: asClass(FetchProductService).singleton(),
        removeProductService: asClass(RemoveProductService).singleton(),
        supplyProductService: asClass(SupplyProductService).singleton(),
        productCreator: asClass(ProductCreator).singleton(),
        productFetcher: asClass(ProductFetcher).singleton(),
        productRemover: asClass(ProductRemover).singleton(),
        productSupplier: asClass(ProductSupplier).singleton(),
        productRepository: asClass(PrismaProductRepository).singleton(),
        createProductController: asClass(CreateProductController).singleton(),
        fetchProductController: asClass(FetchProductController).singleton(),
        removeProductController: asClass(RemoveProductController).singleton(),
        supplyProductController: asClass(SupplyProductController).singleton(),
      });
  }

  public invoke(): AwilixContainer {
    return this.container;
  }
}
