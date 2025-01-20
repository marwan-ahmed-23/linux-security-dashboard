# Linux Security Dashboard

## 1. Introduction
The **Linux Security Dashboard** (LSD) is a full-stack application designed to monitor and analyze critical security-related data on Linux systems. It aggregates information such as open ports, system resource usage, failed login attempts, and potential vulnerabilities into a single, user-friendly interface. The goal is to provide system administrators and security enthusiasts a clear and actionable overview of their server’s security posture.

## 2. Features
- **Comprehensive System Info**  
  Collect CPU, memory, and uptime statistics, along with open ports and top processes.
- **Failed Login Monitoring**  
  Parse system logs (e.g., `/var/log/auth.log` or journalctl) to list recent failed login attempts.
- **Vulnerability Scanning**  
  Integrate tools like Nmap scripts or ClamAV for discovering common vulnerabilities.
- **Real-Time Alerts**  
  (Optional) Send notifications via Slack or email when certain thresholds are exceeded (e.g., repeated login failures).
- **Modular Architecture**  
  Separates the backend (data collection & APIs) from the frontend (visualization), ensuring scalability and maintainability.

## 3. Project Architecture

### 3.1 Backend (API Layer)
- **Node.js & Express** (or Python/Flask if preferred) to handle REST API endpoints.
- **Utility scripts** that execute OS commands (like `ss`, `grep`, or `nmap`) to gather security data.
- **Models** (optional) if you store historical logs in a database (MongoDB, PostgreSQL, etc.).

### 3.2 Frontend (UI Layer)
- **React** (or Vue/Angular) for creating interactive dashboards.
- **Charting Libraries** (e.g., Chart.js, Recharts) for graphical representation of system data.
- **Axios** (or Fetch API) to request data from the backend.

### 3.3 Database (Optional)
- **MongoDB** or **PostgreSQL** to persist historical log data, vulnerability scan results, or configurations.
- Helps in producing long-term trend analysis and advanced reporting.

## 4. Implementation Details

### 4.1 Data Collection Workflows
1. **System Queries**  
   - Gather CPU, memory, uptime with built-in Node.js/`os` module or OS commands.
   - Identify open ports using `ss -tuln` or `netstat`.
2. **Log Analysis**  
   - Parse `/var/log/auth.log` or utilize `journalctl` to find failed SSH login attempts.
   - Store critical events in a DB or return them on-demand via an API endpoint.

### 4.2 Vulnerability Scanning
1. **Nmap Integration**  
   - Use Nmap scripts (`nmap -sV --script=vuln`) for quick vulnerability detection.
   - Parse the command output and return structured results to the frontend.
2. **ClamAV (Optional)**  
   - Provide endpoints to scan directories for malware or trojans.
   - Summarize findings in the dashboard with potential remediation steps.

### 4.3 Real-Time Alerts & Notifications
1. **Alert Thresholds**  
   - Set maximum allowed failed logins within a specified timeframe.
   - Configure triggers for newly opened suspicious ports or high CPU usage.
2. **Slack/Email Integration**  
   - Use a dedicated Node.js package (like Nodemailer or Slack Webhooks) to dispatch messages.
   - Link these triggers to a simple UI in the frontend (e.g., “Alert Settings”).

### 4.4 Security & Authentication
1. **Role-Based Access (Optional)**  
   - Protect your dashboard behind a user login system.
   - Use JSON Web Tokens (JWT) or Basic Auth for secure routes.
2. **HTTPS Enforcement**  
   - Serve the dashboard over HTTPS for encrypted communication.
   - Utilize certbot/Let’s Encrypt for free SSL certificates in production setups.

## 5. Installation

1. **Clone the Repository**  
   ```bash
   git clone https://github.com/marwan-ahmed-23/linux-security-dashboard.git
   ```
2. **Backend Setup**  
   ```bash
   cd linux-security-dashboard/backend
   npm install
   npm run dev   # or npm start in production
   ```
   By default, this runs on `http://localhost:5000`.
3. **Frontend Setup**  
   ```bash
   cd ../frontend
   npm install
   npm start
   ```
   The development server will launch on `http://localhost:3000`.
4. **Database Configuration** (Optional)  
   - If using MongoDB, run the service locally or point `DB_URI` to a remote instance.
   - Update environment variables in `.env` (e.g., `DB_URI`, `JWT_SECRET`) for a production deployment.

## 6. Usage

1. **Open the Dashboard**  
   Navigate to `http://localhost:3000` in your browser.
2. **View System Status**  
   - Check CPU/Memory usage, open ports, and vulnerability scans in real time.
3. **Review Security Logs**  
   - Monitor and investigate failed login attempts or other events flagged by the system.
4. **Run Vulnerability Scans**  
   - Trigger an Nmap-based scan and see the results in your dashboard.

## 7. Docker Setup (Optional)

1. **docker-compose.yml**  
   If provided, edit the environment variables to match your preferences (ports, DB credentials, etc.).
2. **Build & Run**  
   ```bash
   docker-compose up --build
   ```
3. **Container Ports**  
   - **Backend** on `http://localhost:5000`
   - **Frontend** on `http://localhost:3000`
   - **Database** (if included) on `http://localhost:27017` (for MongoDB) or `http://localhost:5432` (for PostgreSQL)

## 8. Contributing

1. **Fork** the repository.
2. **Create a new branch** (`git checkout -b feature/my-improvement`).
3. **Commit** your changes (`git commit -m "Add new feature"`).
4. **Push** to your branch (`git push origin feature/my-improvement`).
5. **Open a Pull Request** on GitHub, detailing your changes and their purpose.

## 9. License

This project is licensed under the [MIT License](LICENSE). You are free to modify, distribute, and use it in personal or commercial projects.

---

**We hope this Linux Security Dashboard becomes your go-to tool for Linux system protection.** If you have any questions, issues, or feature requests, feel free to open an issue or submit a pull request. Happy monitoring!