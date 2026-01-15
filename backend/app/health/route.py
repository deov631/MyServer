from fastapi import APIRouter

router = APIRouter()

@router.get("/ping")
async def ping():
    return '"Still, every realm holds its own unanswered mysteries."'

