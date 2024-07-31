import { Controller } from '../Controller';
import { Request, Response } from 'express';
import httpStatus from 'http-status';

export class HealthController implements Controller {
  async run(_: Request, res: Response): Promise<void> {
    res.status(httpStatus.OK).json({ message: 'OK' });
  }
}
