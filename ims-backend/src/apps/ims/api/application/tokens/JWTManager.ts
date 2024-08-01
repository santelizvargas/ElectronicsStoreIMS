import jwt from 'jsonwebtoken';
import JWTConfig from './JWTConfig';

export default class JWTManager {
  constructor(private jwtConfig: JWTConfig) {}

  public generate(data: string | Buffer | object): { accessToken: string; expiresIn: number | string } {
    const accessToken = jwt.sign(data, this.jwtConfig.secret, {
      // The algorith will enable when we have the JWT perm key
      // algorithm: this.jwtConfig.algorithm,
      expiresIn: this.jwtConfig.expiresIn,
    });

    return {
      accessToken,
      expiresIn: this.jwtConfig.expiresIn,
    };
  }
}
