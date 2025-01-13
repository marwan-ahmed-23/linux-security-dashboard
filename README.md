# 🛡️ Enhanced Linux Security Dashboard

**Linux Security Dashboard** is a dynamic, open-source tool designed to monitor and enhance Linux system security. This version combines detailed security insights with an improved UI, additional features, and better performance.

---

## 🚀 Features

- 🔥 **Firewall Status Monitoring**:
  - Check if UFW is active and list the current rules.

- 🔐 **Sensitive File Permissions**:
  - Audit critical system files (e.g., `/etc/passwd`, `/etc/shadow`).

- 👤 **User Management**:
  1. Identify inactive or suspicious user accounts.
  2. Detect users with administrative privileges (sudo).

- 🛠️ **System Updates**:
  1. Check for available security updates.
  2. Highlight outdated packages.

- 🌐 **Network Activity Monitoring**:
  1. Display active network connections (TCP/UDP).
  2. Detect suspicious external connections.

- 🕵️ **Vulnerability Scanning**:
  1. Analyze installed packages for known CVEs using `osv-scanner`.
  2. Detect weak SSH configurations for enhanced security.
  3. Perform comprehensive system audits using `lynis`.

- 📊 **Log Analysis**:
  1. Analyze system logs (`/var/log/syslog`, `/var/log/auth.log`).
  2. Identify errors and warnings for further investigation.

- 🛡️ **File Integrity Monitoring**:
  1. Monitor critical system files (e.g., `/etc/passwd`, `/etc/shadow`) for unauthorized changes.
  2. Generate and compare SHA-256 hashes to ensure file integrity.

- 📊 **Dynamic Reporting**:
  1. Generate detailed reports in text and HTML formats.
  2. HTML reports include an easy-to-read, structured layout with responsive design.

- 👤 **User Privilege Analysis**:
  1. Identify users with sudo privileges.
  2. Detect users without passwords.
  3. Highlight users with open home directories.

- 🌐 **Advanced Security Vulnerability Detection**:
  1. Perform `lynis` system audits.
  2. Analyze SSH configurations for weak settings and provide recommendations.

- 🌐 **Web Interface** (Planned):
  1. A lightweight web-based dashboard for real-time security monitoring.


## 📂 Directory Structure

```plaintext
linux-security-dashboard/
├── security-dashboard.sh              # Main script for security checks
├── security-dashboard-report.txt      # Example text report
├── security-dashboard-report.html     # Example HTML report
├── styles.css                         # Enhanced styling for HTML reports
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
3. Install `osv-scanner` if not already installed:
   ```bash
   sudo apt install osv-scanner
   ```
4. Optional: Install `lynis` for advanced auditing:
   ```bash
   sudo apt install lynis
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
Available Updates:
openssl 1.1.1-1ubuntu2.1 -> 1.1.1-1ubuntu2.2
curl 7.68.0-1ubuntu2.7 -> 7.68.0-1ubuntu2.8
---------------------------------------
Suspicious Processes:
High Resource Usage:
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root      1234 55.0 60.2 200000 12000 ?       R    12:00   0:30 suspicious_process

Unusual Root Processes:
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root      5678 80.0 70.0 300000 15000 ?       R    12:01   1:20 malicious_tool
---------------------------------------
Network Activity:
Active Connections:
Proto Recv-Q Send-Q Local Address           Foreign Address         State
tcp        0      0 127.0.0.1:3306          0.0.0.0:*               LISTEN
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN
---------------------------------------
Log Analysis:
Errors:
- Disk quota exceeded
- Authentication failure for user root

Warnings:
- High memory usage detected
---------------------------------------
```

### HTML Report:

Open `security-dashboard-report.html` for a visually structured version of the report.

## 🛠️ Planned Features

- Advanced User Analysis:
- Highlight users with risky configurations or recent failed login attempts.
- Task Automation:
- Schedule periodic scans using `cron` or `systemd`.
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
