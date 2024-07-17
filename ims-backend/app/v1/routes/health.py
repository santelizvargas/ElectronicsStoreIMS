from fastapi import APIRouter


health_router = APIRouter(
  tags=["Health checker"],
)

@health_router.get('/health')
async def health():
  return { 'message': 'OK' }
