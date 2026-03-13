from collections import OrderedDict
from fastapi import APIRouter, HTTPException
from pydantic import BaseModel, Field

router = APIRouter()

clipboards = OrderedDict()
MAX_CLIPBOARDS = 20

class Clipboard(BaseModel):
    id: str = Field(max_length=4)
    content: str = Field(max_length=100000)

@router.get("/{clipboard_id}")
async def get_clipboard(clipboard_id: str):
    """Get a clipboard"""
    if clipboard_id in clipboards:
        return Clipboard(id=clipboard_id, content=clipboards[clipboard_id])
    else:
        raise HTTPException(status_code=404, detail="Clipboard not found")

@router.post("/{clipboard_id}")
async def set_clipboard(clipboard_id: str, clipboard: Clipboard):
    """Set a clipboard, creating it if it doesn't exist"""
    clipboards[clipboard_id] = clipboard.content
    if len(clipboards) > MAX_CLIPBOARDS:
        clipboards.popitem(last=False)
    return {"message": "Clipboard updated"}

@router.delete("/{clipboard_id}")
async def delete_clipboard(clipboard_id: str):
    """Delete a clipboard"""
    if clipboard_id in clipboards:
        del clipboards[clipboard_id]
        return {"message": "Clipboard deleted"}
    else:
        raise HTTPException(status_code=404, detail="Clipboard not found")
