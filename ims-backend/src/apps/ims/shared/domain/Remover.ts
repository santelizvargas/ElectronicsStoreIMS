export interface Remover<Request, Response> {
  invoke(request: Request): Promise<Response>;
}
