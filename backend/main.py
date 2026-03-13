from fastapi import FastAPI

from app.clip.route import router as clip_router
from app.health.route import router as health_router

fastapi_app = FastAPI()

# Routes
fastapi_app.include_router(clip_router, prefix="/api/clip")
fastapi_app.include_router(health_router, prefix="/api/health")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(fastapi_app, host="0.0.0.0", port=20000)
