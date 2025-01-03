# 🛡️ Linux Security Dashboard

**Linux Security Dashboard** is a comprehensive, open-source tool designed to monitor and enhance the security of Linux systems. It provides detailed security insights, including firewall status, file permissions, user activity, network monitoring, and system vulnerabilities, through dynamic reports in text and HTML formats.

---

## 🚀 Features
- 🔥 **Firewall Status Monitoring**: Check if UFW is active and list the current rules.
- 🔐 **Sensitive File Permissions**: Audit critical system files (e.g., `/etc/passwd`, `/etc/shadow`).
- 👤 **User Management**:
  1. Identify inactive or suspicious user accounts.
  2. Detect users with administrative privileges (sudo).
- 🛠️ **System Updates**:
  1. Check for available security updates.
  2. Highlight outdated packages.
- 🌐 **Network Activity Monitoring**:
  1. Display active network connections (TCP/UDP).
  2. Detect suspicious external connections.
- 🕵️ **Vulnerability Scanning** (Planned):
  1. Analyze the system for known CVEs.
- 📊 **Dynamic Reporting**:
  1. Generate detailed reports in text and HTML formats.
  2. HTML reports include an easy-to-read, structured layout.
- 🌐 **Web Interface** (Planned):
  1. A lightweight web-based dashboard for real-time security monitoring.


## 📂 Directory Structure

```plaintext
linux-security-dashboard/
├── security-dashboard.sh              # Main script for security checks
├── security-dashboard-report.txt      # Example text report
├── security-dashboard-report.html     # Example HTML report
├── LICENSE                            # License file
└── README.md                          # Documentation
```

## 📖 Usage
### Installation
1. Clone the repository:
    ```bash
    git clone https://github.com/marwan-ahmed-23/linux-security-dashboard.git
    cd linux-security-dashboard
    ```
2. Make the script executable:
    ```bash
    chmod +x security-dashboard.sh
    ```
### Running the Tool
1. Run the script:
    ```bash
    ./security-dashboard.sh
    ```
2. View the reports:
    - **Text Report:**
        ```bash
        cat security-dashboard-report.txt
        ```
    - HTML Report: Open `security-dashboard-report.html` in any browser.

## 🖼️ Example Output
**Text Report:**
```plaintext
Security Report - Thu Dec 21 2024
---------------------------------------
Firewall Status:
Status: active
To                         Action      From
--                         ------      ----
22                         ALLOW       Anywhere
---------------------------------------
Sensitive File Permissions:
/etc/passwd -rw-r--r--
/etc/shadow -rw-------
/etc/hosts -rw-r--r--
---------------------------------------
Inactive Users:
guest
backup
---------------------------------------
System Updates:
The following packages can be updated:
 - openssl
 - libc6
 - curl
---------------------------------------
Network Activity:
Active Connections:
Proto Recv-Q Send-Q Local Address           Foreign Address         State
tcp        0      0 127.0.0.1:3306          0.0.0.0:*               LISTEN
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN

Suspicious External Connections:
tcp        0      0 192.168.1.100:54321     23.45.67.89:80          ESTABLISHED
```

### HTML Report:
Open `security-dashboard-report.html` for a visually structured version of the report.

## 🛠️ Planned Features
- Vulnerability Scanning:
- Integrate tools like `osv-scanner` or `lynis` to detect known CVEs.
- Advanced User Analysis:
- Highlight users with risky configurations or recent failed login attempts.
- Web Interface:
- Provide a lightweight web dashboard for real-time security monitoring.
- Task Automation:
- Schedule periodic scans using `cron` or systemd timers.
- Custom Rules:
- Allow users to define specific rules for security checks.

## 🤝 Contributions
We welcome contributions from the community! Here’s how you can help:

1. Fork the repository.
2. Create a new branch for your feature or bug fix:
    ```bash
    git checkout -b feature-name
    ```
3. Commit your changes:
    ```bash
    git commit -m "Added a new feature"
    ```
4. Push your branch:
    ```bash
    git push origin feature-name
    ```
5. Submit a pull request with details about your changes.

## 🌟 Show Your Support
If you find this project helpful, please give it a ⭐ on GitHub! Your support motivates us to improve and expand the tool.

## 🔖 License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.
