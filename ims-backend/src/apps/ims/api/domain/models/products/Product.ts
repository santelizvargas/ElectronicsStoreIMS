export type Product = {
  id: number;
  name: string;
  description?: string | null;
  stock: number;
  salePrice: number;
  purchasePrice: number;
  createdAt: Date | string;
  updatedAt: Date | string;
  deletedAt?: Date | string | null;
  images?: string[]; // TODO: Update to Image[] when Image model is created
};
