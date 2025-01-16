import subprocess

def get_open_ports():
    try:
        cmd = "ss -tuln"
        output = subprocess.check_output(cmd, shell=True).decode('utf-8')
        lines = output.strip().split('\n')[1:]  
        ports = []
        for line in lines:
            columns = line.split()
            protocol = columns[0]
            local_address = columns[4]
            ports.append({
                "protocol": protocol,
                "address": local_address
            })
        return ports
    except Exception as e:
        return {"error": str(e)}

def get_running_processes():
    try:
        cmd = "ps aux --sort=-%mem | head -n 10" 
        output = subprocess.check_output(cmd, shell=True).decode('utf-8')
        lines = output.strip().split('\n')[1:] 
        processes = []
        for line in lines:
            parts = line.split(maxsplit=10)
            if len(parts) == 11:
                user, pid, cpu, mem, vsz, rss, tty, stat, start, time, command = parts
                processes.append({
                    "pid": pid,
                    "user": user,
                    "cpu_usage": cpu,
                    "mem_usage": mem,
                    "command": command
                })
        return processes
    except Exception as e:
        return {"error": str(e)}

def get_failed_logins():
    try:
        cmd = "grep 'Failed password' /var/log/auth.log | tail -n 10"
        output = subprocess.check_output(cmd, shell=True).decode('utf-8')
        lines = output.strip().split('\n')
        failed_attempts = []
        for line in lines:
            failed_attempts.append(line.strip())
        return failed_attempts
    except Exception as e:
        return {"error": str(e)}
