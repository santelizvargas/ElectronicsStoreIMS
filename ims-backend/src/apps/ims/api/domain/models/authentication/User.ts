// import { Role } from '../rbac/Role';

export type User = {
  id: number;
  firstName: string;
  lastName: string;
  email: string;
  identification: string;
  phone: string;
  address: string;
  password: string;
  // role: Role[];
};
