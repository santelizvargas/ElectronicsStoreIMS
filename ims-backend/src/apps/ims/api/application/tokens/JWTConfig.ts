import { Algorithm } from 'jsonwebtoken';

export default class JWTConfig {
  public readonly secret: string;
  public readonly algorithm: Algorithm;
  public readonly expiresIn: number | string;

  constructor() {
    this.secret = process.env.JWT_SECRET || '';
    this.algorithm = (process.env.JWT_ALGORITHM || 'RS512') as Algorithm;
    this.expiresIn = process.env.JWT_EXPIRES_IN || 60 * 60;
  }
}
