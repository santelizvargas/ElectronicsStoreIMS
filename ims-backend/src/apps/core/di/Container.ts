import { createContainer, asFunction, AwilixContainer, InjectionMode, asClass } from 'awilix';
import { createPrismaClient } from '../../ims/shared/infrastructure/persistence/prisma';
import WinstonLogger from '../../ims/shared/infrastructure/logger/WinstonLogger';
import CredentialsAuthenticator from '../../ims/api/infrastructure/authentication/credentials/CredentialsAuthenticator';
import JWTConfig from '../../ims/api/application/tokens/JWTConfig';
import PrismaAuthenticationRepository from '../../ims/api/infrastructure/authentication/repositories/PrismaAuthenticationRepository';
import AuthenticationService from '../../ims/api/application/authentication/AuthenticationService';
import AuthenticationController from '../../ims/api/infrastructure/express/controllers/authentication/AuthenticationController';
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
import CredentialsPasswordUpdater from '../../ims/api/infrastructure/authentication/credentials/CredentialsPasswordUpdater';
import UpdatePasswordService from '../../ims/api/application/authentication/UpdatePasswordService';
import UpdatePasswordController from '../../ims/api/infrastructure/express/controllers/authentication/UpdatePasswordController';
import AssignRoleController from '../../ims/api/infrastructure/express/controllers/rbac/AssignRoleController';
import AssignRoleService from '../../ims/api/application/rbac/AssignRoleService';
import RoleAssigner from '../../ims/api/infrastructure/rbac/RoleAssigner';
import PrismaRbacRepository from '../../ims/api/infrastructure/rbac/repositories/PrismaRbacRepository';
import ProductCounter from '../../ims/api/infrastructure/products/ProductCounter';
import CountProductController from '../../ims/api/infrastructure/express/controllers/products/CountProductController';
import CountProductService from '../../ims/api/application/products/CountProductService';
import RegisterController from '../../ims/api/infrastructure/express/controllers/authentication/RegisterController';
import RegistrationService from '../../ims/api/application/authentication/RegistrationService';
import CredentialsClientRegister from '../../ims/api/infrastructure/authentication/credentials/CredentialsClientRegister';
import FetchAuthenticationService from '../../ims/api/application/authentication/FetchAuthenticationService';
import AuthenticationFetchController from '../../ims/api/infrastructure/express/controllers/authentication/AuthenticationFetchController';
import ClientFetcher from '../../ims/api/infrastructure/authentication/credentials/ClientFetcher';
import { AWSFileUploader } from '../utils/AWSUploaderFile';
import DisableUserService from '../../ims/api/application/authentication/DisableUserService';
import EnableUserService from '../../ims/api/application/authentication/EnableUserService';
import ClientEnabler from '../../ims/api/infrastructure/authentication/credentials/ClientEnabler';
import EnableController from '../../ims/api/infrastructure/express/controllers/authentication/EnableController';
import DisableController from '../../ims/api/infrastructure/express/controllers/authentication/DisableController';
import ClientRemover from '../../ims/api/infrastructure/authentication/credentials/ClientRemover';
import CreateInvoiceController from '../../ims/api/infrastructure/express/controllers/invoices/CreateInvoiceController';
import CreateInvoiceService from '../../ims/api/application/invoices/CreateInvoiceService';
import InvoiceCreator from '../../ims/api/infrastructure/invoices/InvoiceCreator';
import PrismaInvoiceRepository from '../../ims/api/infrastructure/invoices/repositories/PrismaInvoiceRepository';
import FetchInvoiceController from '../../ims/api/infrastructure/express/controllers/invoices/FetchInvoiceController';
import CountInvoiceController from '../../ims/api/infrastructure/express/controllers/invoices/CountInvoiceController';
import RevokeRoleController from '../../ims/api/infrastructure/express/controllers/rbac/RevokeRoleController';
import UsersChartController from '../../ims/api/infrastructure/express/controllers/authentication/UsersChartController';
import DatabaseConfig from '../config/DatabaseConfig';
import BackupController from '../../ims/api/infrastructure/express/controllers/database/BackupController';
import RestoreController from '../../ims/api/infrastructure/express/controllers/database/RestoreController';
import ListController from '../../ims/api/infrastructure/express/controllers/database/ListController';

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
        databaseConfig: asClass(DatabaseConfig).singleton(),
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
        registrationService: asClass(RegistrationService).singleton(),
        fetchAuthenticationService: asClass(FetchAuthenticationService).singleton(),
        disableService: asClass(DisableUserService).singleton(),
        enableService: asClass(EnableUserService).singleton(),
        authenticationController: asClass(AuthenticationController).singleton(),
        enableController: asClass(EnableController).singleton(),
        disableController: asClass(DisableController).singleton(),
        register: asClass(CredentialsClientRegister).singleton(),
        passwordUpdater: asClass(CredentialsPasswordUpdater).singleton(),
        updatePasswordService: asClass(UpdatePasswordService).singleton(),
        updatePasswordController: asClass(UpdatePasswordController).singleton(),
        registerController: asClass(RegisterController).singleton(),
        authenticationFetchController: asClass(AuthenticationFetchController).singleton(),
        authenticationFetcher: asClass(ClientFetcher).singleton(),
        enableUser: asClass(ClientEnabler).singleton(),
        removerUser: asClass(ClientRemover).singleton(),
        usersChartController: asClass(UsersChartController).singleton(),
      })
      .register({
        createProductService: asClass(CreateProductService).singleton(),
        fetchProductService: asClass(FetchProductService).singleton(),
        removeProductService: asClass(RemoveProductService).singleton(),
        supplyProductService: asClass(SupplyProductService).singleton(),
        countProductService: asClass(CountProductService).singleton(),
        productCreator: asClass(ProductCreator).singleton(),
        productFetcher: asClass(ProductFetcher).singleton(),
        productRemover: asClass(ProductRemover).singleton(),
        productSupplier: asClass(ProductSupplier).singleton(),
        productCounter: asClass(ProductCounter).singleton(),
        productRepository: asClass(PrismaProductRepository).singleton(),
        createProductController: asClass(CreateProductController).singleton(),
        fetchProductController: asClass(FetchProductController).singleton(),
        removeProductController: asClass(RemoveProductController).singleton(),
        supplyProductController: asClass(SupplyProductController).singleton(),
        countProductController: asClass(CountProductController).singleton(),
      })
      .register({
        assignRoleController: asClass(AssignRoleController).singleton(),
        revokeRoleController: asClass(RevokeRoleController).singleton(),
        assignRoleService: asClass(AssignRoleService).singleton(),
        roleAssigner: asClass(RoleAssigner).singleton(),
        rbacRepository: asClass(PrismaRbacRepository).singleton(),
      })
      .register({
        imageUploader: asClass(AWSFileUploader).singleton(),
      })
      .register({
        createInvoiceController: asClass(CreateInvoiceController).singleton(),
        fetchInvoiceController: asClass(FetchInvoiceController).singleton(),
        countInvoiceController: asClass(CountInvoiceController).singleton(),
        createInvoiceService: asClass(CreateInvoiceService).singleton(),
        invoiceCreator: asClass(InvoiceCreator).singleton(),
        invoiceRepository: asClass(PrismaInvoiceRepository).singleton(),
      })
      .register({
        backupController: asClass(BackupController).singleton(),
        restoreController: asClass(RestoreController).singleton(),
        listController: asClass(ListController).singleton(),
      });
  }

  public invoke(): AwilixContainer {
    return this.container;
  }
}
