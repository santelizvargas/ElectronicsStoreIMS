declare global {
  namespace NodeJS {
    interface ProcessEnv {
      BASE_URL: string;
      NODE_ENV: 'development' | 'staging' | 'production';
      PORT?: string;
      API_PREFIX: string;
      API_VERSION: string;
    }
  }
}

export {};
