import type { Request, Response, NextFunction } from 'express';

export interface Controller {
  invoke(request: Request, response: Response, next: NextFunction): Promise<Response | void>;
}
