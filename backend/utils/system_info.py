import platform
import psutil

def get_system_info():
    info = {
        "os": platform.system(),
        "hostname": platform.node(),
        "release": platform.release(),
        "architecture": platform.machine(),
        "cpu_count": psutil.cpu_count(logical=True),
        "memory_total_gb": round(psutil.virtual_memory().total / (1024**3), 2)
    }
    return info
