import App from './App';

process.on('uncaughtException', (error: Error) => {
  console.log('uncaughtException', error);
  process.exit(1);
});

function handleError(error: Error): void {
  console.log(error);
  process.exit(1);
}

function bootstrap(): void {
  const app = new App();
  app.start().catch(handleError);
}

bootstrap();
