import { NextFunction, Request, Response } from 'express';
import { ErrorFormatter, validationResult } from 'express-validator';
import httpStatus from 'http-status';

export const RequestValidator = (req: Request, res: Response, next: NextFunction): Response | void => {
  const errorFormatter: ErrorFormatter = ({ msg: message, type }) => {
    return { message, type };
  };

  const errors = validationResult(req).formatWith(errorFormatter).array({ onlyFirstError: true });
  if (errors.length > 0) {
    return res.status(httpStatus.UNPROCESSABLE_ENTITY).json({ errors });
  }
  return next();
};
