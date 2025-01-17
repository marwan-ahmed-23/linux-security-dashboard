# Linux Security Dashboard

A Flask-based dashboard for monitoring key security-related information on a Linux system. It retrieves and displays system info, open ports, top processes, and recent failed login attempts—ideal for quick, at-a-glance security checks. Now updated with **Basic Auth** protection, **optional Slack alerts**, and **Docker** support.

---


## Table of Contents

1. [Features](#features)
2. [Tech Stack](#tech-stack)
3. [Installation](#installation)
4. [Usage](#usage)
5. [Project Structure](#project-structure)
6. [Customization](#customization)
7. [Security Disclaimer](#security-disclaimer)
8. [Contributing](#contributing)
9. [License](#license)


## Features

- **System Info**:  
  View basic OS, CPU, and memory details using `platform` and `psutil`.

- **Open Ports**:  
  Display open TCP/UDP ports using `ss` (or `netstat`).

- **Top Processes**:  
  List top memory-consuming processes via `ps` command.

- **Failed Login Attempts**:  
  Show recent failed logins from `/var/log/auth.log` (or via `journalctl`).

- **Slack Notifications (Optional)**:  
  Sends a message to Slack when failed logins are detected, using an incoming webhook.  

- **Basic Auth**:  
  Protect API routes with a username/password to restrict access.  

- **Docker Support**:  
  Easily run the dashboard in a container for quick deployment.  

- **Responsive UI**:  
  Built with Bootstrap and Font Awesome for a modern, mobile-friendly interface.  


## Tech Stack

- **Python 3.9+**  
  For the Flask backend, including subprocess calls and `psutil` for system info.  

- **Flask & Flask-CORS**  
  Provides API endpoints and handles cross-origin requests for the dashboard UI.  

- **HTML/CSS/JS**  
  Front-end interface in `index.html`, `styles.css`, and `dashboard.js`.  

- **Bootstrap 5 & Font Awesome**  
  Ensures a responsive layout and professional icons.  

- **(Optional) Slack API**  
  For sending alerts via an incoming webhook.  


## Installation

1. **Clone the repository**:  
    ```bash
    git clone https://github.com/marwan-ahmed-23/linux-security-dashboard.git
    ```  

2. **Install Backend Dependencies**:  
    Navigate to the `backend` folder and install the required Python packages:  
    ```bash
    cd linux-security-dashboard/backend
    pip install -r requirements.txt
    ```  
    Make sure `psutil` is listed in `requirements.txt` if you plan to use it for system info.

3. **(Optional) Configure Basic Auth & Slack**:  
    - Set environment variables: `BASIC_AUTH_USERNAME`, `BASIC_AUTH_PASSWORD`, and `SLACK_WEBHOOK_URL`.  
    - For local testing, you can set them in your terminal (e.g., `export BASIC_AUTH_USERNAME=admin` on Linux) or directly in your environment.

4. **Start the Flask Server**:  
    Still in the `backend` directory:  
    ```bash
    python app.py
    ```
    By default, Flask runs on `http://0.0.0.0:5000` (or `http://localhost:5000`).


## Usage

1. **Open the Frontend**  
    - Go to the `frontend` folder and open `index.html` in your web browser.  
    - Alternatively, serve `frontend` files with any static file server (e.g., `python -m http.server 8000`), then navigate to `http://localhost:8000`.

2. **Access Protected Endpoints**  
    If Basic Auth is enabled, you’ll need to enter the username/password you set in your environment variables (e.g., `admin` / `secret`) when making requests to the Flask API.  

3. **View the Dashboard**  
    You will see sections for system info, open ports, processes, and recent failed logins. If Slack is configured, it will send a notification whenever the dashboard detects failed login attempts.


## Project Structure

```plaintext
linux-security-dashboard/
├── backend/
│   ├── app.py                 # Main Flask application (with API routes, Basic Auth, Slack alerts)
│   ├── config.py              # Configuration for environment variables
│   ├── requirements.txt       # Python dependencies
│   └── utils/
│       ├── system_info.py     # Helper functions for system info (CPU, mem, OS)
│       └── security_checks.py # Functions to get open ports, processes, and failed logins
├── frontend/
│   ├── index.html             # Dashboard page
│   ├── css/
│   │   └── styles.css         # Custom stylesheet
│   └── js/
│       └── dashboard.js       # Main dashboard logic (fetch & display data)
├── Dockerfile                 # Docker support for easy containerization
├── LICENSE                    # License file
└── README.md                  # Project documentation
```

## Customization

- **Backend Scripts**  
  Modify commands in `security_checks.py` to align with your Linux distribution. For example, replace `grep /var/log/auth.log` with `journalctl -u ssh.service`.

- **Sorting & Filtering**  
  In `dashboard.js`, adjust how processes or ports are sorted, or how many items are displayed.

- **Security Enhancements**  
  1. Add IP restrictions or more advanced auth methods (e.g., OAuth or token-based) for production usage.  
  2. Use HTTPS for secure data transfer.
  3. Limit access to logs or commands that require elevated privileges.

- **Docker or Other Deployment**  
  - Build a Docker image with the included `Dockerfile`.
  - Deploy on any platform supporting Flask (AWS, Heroku, Docker, etc.).
  - Example Docker commands:
    ```bash
      # From the project's root directory
      docker build -t linux-sec-dashboard .

      docker run -d \
        -p 5000:5000 \
        -e BASIC_AUTH_USERNAME=myuser \
        -e BASIC_AUTH_PASSWORD=mypassword \
        -e SLACK_WEBHOOK_URL=https://hooks.slack.com/services/XXXX/XXXX/XXXX \
        --name linux_security_dashboard \
        linux-sec-dashboard
    ```


## Security Disclaimer

- Running commands like `grep /var/log/auth.log` may require root or sudo privileges.  
- This dashboard is intended for **educational** and **informational** purposes.  
- Always secure your server, restrict dashboard access, and review logs responsibly.  
- Use at your own risk and comply with your organization’s security policies.  



## Contributing

We welcome contributions from the community! Here’s how you can help:  

1. **Fork** the repository.  
2. **Create a new branch** for your feature or bug fix:  
   ```bash
   git checkout -b feature-name
   ```  
3. **Commit your changes**:  
   ```bash
   git commit -m "Added a new feature"
   ```  
4. **Push your branch**:  
   ```bash
   git push origin feature-name
   ```  
5. **Open a Pull Request** on GitHub.  

## 🌟 Show Your Support

If you find this project helpful, please give it a ⭐ on GitHub! Your support motivates us to improve and expand the tool.  

## License  

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.  

---

**Enjoy your enhanced Linux Security Dashboard!** For any questions or suggestions, feel free to open an issue or pull request.  