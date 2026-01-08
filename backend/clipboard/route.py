from fastapi import APIRouter, HTTPException
from pydantic import BaseModel

router = APIRouter()

clipboards = {}

class Clipboard(BaseModel):
    id: str
    content: str

@router.get("/{clipboard_id}")
async def get_clipboard(clipboard_id: str):
    if clipboard_id in clipboards:
        return Clipboard(id=clipboard_id, content=clipboards[clipboard_id])
    else:
        raise HTTPException(status_code=404, detail="Clipboard not found")

@router.post("/{clipboard_id}")
async def set_clipboard(clipboard_id: str, clipboard: Clipboard):
    clipboards[clipboard_id] = clipboard.content
    return {"message": "Clipboard updated"}

@router.delete("/{clipboard_id}")
async def delete_clipboard(clipboard_id: str):
    if clipboard_id in clipboards:
        del clipboards[clipboard_id]
        return {"message": "Clipboard deleted"}
    else:
        raise HTTPException(status_code=404, detail="Clipboard not found")
