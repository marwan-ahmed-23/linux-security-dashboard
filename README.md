# Linux Security Dashboard

A Flask-based dashboard for monitoring key security-related information on a Linux system. It retrieves and displays system info, open ports, top processes, and recent failed login attempts—ideal for quick, at-a-glance security checks.

---


## Table of Contents

1. [Tech Stack](#tech-stack)
2. [Installation](#installation)
3. [Usage](#usage)
4. [Project Structure](#project-structure)
5. [Customization](#customization)
6. [Security Disclaimer](#security-disclaimer)
7. [Contributing](#contributing)
8. [License](#license)


## Features

- **System Info**:  
  View basic OS, CPU, and memory details using `platform` and `psutil`.

- **Open Ports**:  
  Display open TCP/UDP ports using `ss` (or `netstat`).

- **Top Processes**:  
  List top memory-consuming processes via `ps` command.

- **Failed Login Attempts**:  
  Show recent failed logins from `/var/log/auth.log` (or via `journalctl`).

- **Responsive UI**:  
  Built with Bootstrap for a modern look.


## Tech Stack

- **Python 3.9+**  
  Used for the Flask backend, subprocess calls, and `psutil` for system information.

- **Flask & Flask-CORS**  
  Serves the API endpoints and handles cross-origin requests from the dashboard UI.

- **HTML/CSS/JS**  
  Forms the front-end interface (in `index.html`, `styles.css`, `dashboard.js`).

- **Bootstrap 5 & Font Awesome**  
  Provides responsive layout and icons for a professional appearance.


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

3. **(Optional) Adjust Scripts**:  
    - In `security_checks.py`, customize commands based on your Linux distribution (e.g., use `journalctl` instead of `grep /var/log/auth.log`).  
    - In `app.py`, you can change the port or add authentication if needed.  


## Usage

1. **Start the Flask Server**  
    From the `backend` directory, run:  
    ```bash
    python app.py
    ```  
    By default, Flask will run on `http://0.0.0.0:5000` (or `http://localhost:5000`).  

2. **Open the Frontend**  
    - In the `frontend` folder, open `index.html` in your web browser.  
    - Alternatively, serve `frontend` files using any static file server. For example:  
        ```bash
        python -m http.server 8000
        ```  
      Then, visit `http://localhost:8000`.  

3. **View the Dashboard**  
    You should see the main page with system info, open ports, processes, and recent failed login attempts. Data is fetched via AJAX calls to the Flask API.  


## Project Structure
```plaintext
linux-security-dashboard/
├── backend/
│   ├── app.py               # Main Flask application
│   ├── requirements.txt     # Python dependencies
│   └── utils/
│       ├── system_info.py   # Helper functions for system info
│       └── security_checks.py
├── frontend/
│   ├── index.html           # Dashboard page
│   ├── css/
│   │   └── styles.css       # Custom stylesheet
│   └── js/
│       └── dashboard.js     # Main dashboard logic (fetching and displaying data)
├── LICENSE                  # License file
└── README.md                # Project documentation
```

## Customization

- **Backend Scripts**  
  Modify commands in `security_checks.py` to align with your distribution’s tooling. For instance, use `journalctl -u ssh.service` on certain distros.

- **Sorting & Filtering**  
  In `dashboard.js`, adjust how processes or ports are sorted, or how many items are displayed.

- **Security Enhancements**  
  1. Add authentication or IP-based restrictions to protect the dashboard.  
  2. Use HTTPS for secure data transfer.

- **Docker or Other Deployment**  
  Build a Dockerfile if you want a containerized environment. Alternatively, deploy on any platform supporting Flask (e.g., AWS, Heroku).


## Security Disclaimer

- Running commands like `grep /var/log/auth.log` may require root or sudo privileges.  
- This dashboard is intended for educational and informational purposes.  
- Always secure your server and restrict access to the dashboard.  
- Use at your own risk and ensure compliance with your organization’s security policies.  



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

Enjoy your enhanced Linux Security Dashboard! For any questions or suggestions, feel free to open an issue or pull request.  