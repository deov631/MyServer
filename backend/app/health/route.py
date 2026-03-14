from fastapi import APIRouter
import psutil
import asyncio
import time

router = APIRouter()

@router.get("/ping")
async def ping():
    return '"Still, every realm holds its own unanswered mysteries."'

@router.get("/cpu")
async def get_cpu_usage():
    """返回当前操作系统的总 CPU 使用率"""
    cpu_percent = await asyncio.to_thread(psutil.cpu_percent, interval=1)
    return {
        "percent": cpu_percent
    }

@router.get("/memory")
async def get_memory_usage():
    """返回总内存使用率与已使用内存"""
    mem_info = await asyncio.to_thread(psutil.virtual_memory)
    return {
        "percent": mem_info.percent,
        "used_gb": round(mem_info.used / (1024 ** 3), 2),
        "total_gb": round(mem_info.total / (1024 ** 3), 2),
    }

# 上次网络统计数据
_internet_time: float | None = None
_internet_sent: int | None = None
_internet_recv: int | None = None

@router.get("/network")
async def get_network_usage():
    """返回操作系统的下载速率与上传速率（MB/s）"""
    global _internet_time, _internet_sent, _internet_recv
    
    # 获取当前网络统计
    net_current = await asyncio.to_thread(psutil.net_io_counters)
    current_time = time.time()
    
    # 如果有上次的统计数据，计算速率
    if _internet_time is not None and current_time > _internet_time:
        time_delta = current_time - _internet_time
        upload_speed = (net_current.bytes_sent - _internet_sent) / (1024 ** 2) / time_delta
        download_speed = (net_current.bytes_recv - _internet_recv) / (1024 ** 2) / time_delta
    else:
        # 第一次调用，无法计算速率
        upload_speed = 0.0
        download_speed = 0.0
    
    # 更新统计数据
    _internet_time = current_time
    _internet_sent = net_current.bytes_sent
    _internet_recv = net_current.bytes_recv
    
    return {
        "upload_mbps": round(upload_speed, 2),
        "download_mbps": round(download_speed, 2)
    }
