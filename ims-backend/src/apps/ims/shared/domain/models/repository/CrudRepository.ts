export interface CrudRepository<Request, Response> {
  findAll(): Promise<Response[]>;
  find(id: number): Promise<Response | null>;
  create(model: Request): Promise<Response>;
  update(model: Request): Promise<void>;
  delete(id: number): Promise<void>;
}
