import winston, { Logger as WinstonLoggerType } from 'winston';
import { Logger } from '../../domain/Logger';

enum LogLevel {
  DEBUG = 'debug',
  ERROR = 'error',
  INFO = 'info',
}

export default class WinstonLogger implements Logger {
  private logger: WinstonLoggerType;

  constructor() {
    this.logger = winston.createLogger({
      format: winston.format.combine(
        winston.format.prettyPrint(),
        winston.format.errors({ stack: true }),
        winston.format.splat(),
        winston.format.colorize(),
        winston.format.simple(),
      ),
      transports: [
        new winston.transports.Console(),
        new winston.transports.File({ filename: `logs/${LogLevel.DEBUG}.log`, level: LogLevel.DEBUG }),
        new winston.transports.File({ filename: `logs/${LogLevel.ERROR}.log`, level: LogLevel.ERROR }),
        new winston.transports.File({ filename: `logs/${LogLevel.INFO}.log`, level: LogLevel.INFO }),
      ],
    });
  }

  debug(message: string) {
    this.logger.debug(message);
  }

  error(message: string | Error) {
    this.logger.error(message);
  }

  info(message: string) {
    this.logger.info(message);
  }
}
