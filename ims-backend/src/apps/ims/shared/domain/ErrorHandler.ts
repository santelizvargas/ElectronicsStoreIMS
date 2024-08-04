export class ErrorHandler extends Error {
  constructor(
    public message: string,
    public code: number,
  ) {
    super();
    this.message = message;
    this.code = code;
  }

  toJson() {
    return {
      message: this.message,
      code: this.code,
    };
  }
}
