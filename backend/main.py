from fastapi import FastAPI
from clipboard.route import router as clipboard_router

app = FastAPI()
app.include_router(clipboard_router, prefix="/clip")

@app.get("/")
async def root():
    return {"message": "Hello World"}

@app.get("/hello/{name}")
async def say_hello(name: str):
    return {"message": f"Hello {name}"}