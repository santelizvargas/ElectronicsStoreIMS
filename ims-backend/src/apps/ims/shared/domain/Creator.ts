export interface Creator<Request, Response> {
  invoke(request: Request): Promise<Response>;
}
