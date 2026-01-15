from fastapi import FastAPI
from starlette.responses import FileResponse
from starlette.staticfiles import StaticFiles

from app.clip.route import router as clip_router
from app.health.route import router as health_router

fastapi_app = FastAPI()

# Routes
fastapi_app.include_router(clip_router, prefix="/api/clip")
fastapi_app.include_router(health_router, prefix="/api/health")

# Static files
@fastapi_app.get("/")
async def root():
    return FileResponse("static/index.html")

fastapi_app.mount("/", StaticFiles(directory="static"), name="static")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(fastapi_app, host="0.0.0.0", port=12000)
