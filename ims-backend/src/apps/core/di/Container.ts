import { createContainer, asFunction, AwilixContainer, InjectionMode } from 'awilix';
import { createPrismaClient } from '../../ims/shared/persistence/prisma';

export default class Container {
  private readonly container: AwilixContainer;

  constructor() {
    this.container = createContainer({
        injectionMode: InjectionMode.CLASSIC,
    });
  }

  register(): void {
    this.container.register({
        database: asFunction(createPrismaClient).singleton(),
    });
  }

  public invoke(): AwilixContainer {
    return this.container;
  }
}
