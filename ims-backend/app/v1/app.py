from fastapi import FastAPI
from v1.routes.health import health_router
from fastapi.middleware.cors import CORSMiddleware


default_http_permissions = ['*']

# Create FastAPI server
server_v1 = FastAPI(
  title='ElectronicsStoreIMS API V1',
  version='0.0.1',
)

# Include `health` router
server_v1.include_router(router=health_router, prefix='/api/v1')

# Add cors middleware
server_v1.add_middleware(
  CORSMiddleware,
  allow_origins=default_http_permissions,
  allow_methods=default_http_permissions,
  allow_headers=default_http_permissions,
  allow_credentials=True,
)
