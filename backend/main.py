from fastapi import FastAPI
from starlette.responses import FileResponse
from starlette.staticfiles import StaticFiles

from clipboard.route import router as clipboard_router

app = FastAPI()
app.include_router(clipboard_router, prefix="/clip")

@app.get("/")
async def root():
    return FileResponse("static/index.html")

@app.get("/hello/{name}")
async def say_hello(name: str):
    return {"message": f"Hello {name}"}


app.mount("/", StaticFiles(directory="static"), name="static")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=12000)
