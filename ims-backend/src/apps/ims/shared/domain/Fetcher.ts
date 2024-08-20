export interface Fetcher<Response> {
  invoke(): Promise<Response>;
}
