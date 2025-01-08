#!/bin/bash

echo "Starting Linux Security Dashboard..."
echo "====================================="

# Report files
REPORT="security-dashboard-report.txt"
HTML_REPORT="security-dashboard-report.html"

# Initialize HTML report
echo "<!DOCTYPE html><html><head><title>Linux Security Dashboard</title></head><body>" > $HTML_REPORT
echo "<h1>Linux Security Dashboard Report - $(date)</h1>" >> $HTML_REPORT

# Check Firewall Status
echo "[+] Checking Firewall Status..."
if command -v ufw &>/dev/null; then
    FIREWALL_STATUS=$(ufw status)
    echo "Firewall Status:" >> $REPORT
    echo "$FIREWALL_STATUS" >> $REPORT
    echo "<h2>Firewall Status</h2><pre>$FIREWALL_STATUS</pre>" >> $HTML_REPORT
else
    echo "UFW not installed." >> $REPORT
    echo "<h2>Firewall Status</h2><pre>UFW not installed.</pre>" >> $HTML_REPORT
fi

# Check Sensitive File Permissions
echo "[+] Checking File Permissions..."
FILES=("/etc/passwd" "/etc/shadow" "/etc/hosts")
echo "Sensitive File Permissions:" >> $REPORT
echo "<h2>Sensitive File Permissions</h2><ul>" >> $HTML_REPORT
for file in "${FILES[@]}"; do
    if [ -e "$file" ]; then
        PERMISSIONS=$(ls -l "$file")
        echo "$PERMISSIONS" >> $REPORT
        echo "<li>$PERMISSIONS</li>" >> $HTML_REPORT
    else
        echo "$file does not exist." >> $REPORT
        echo "<li>$file does not exist.</li>" >> $HTML_REPORT
    fi
done
echo "</ul>" >> $HTML_REPORT

# Check for System Updates
echo "[+] Checking for Updates..."
if command -v apt &>/dev/null; then
    UPDATES=$(apt list --upgradable 2>/dev/null | tail -n +2)
    echo "Available Updates:" >> $REPORT
    echo "$UPDATES" >> $REPORT
    echo "<h2>Available Updates</h2><pre>$UPDATES</pre>" >> $HTML_REPORT
else
    echo "Package manager not supported." >> $REPORT
    echo "<h2>Available Updates</h2><pre>Package manager not supported.</pre>" >> $HTML_REPORT
fi

# Detect Suspicious Processes
echo "[+] Detecting Suspicious Processes..."
echo "Suspicious Processes:" >> $REPORT
echo "<h2>Suspicious Processes</h2><ul>" >> $HTML_REPORT

# High resource usage processes
HIGH_USAGE=$(ps aux --sort=-%cpu,-%mem | awk '$3>50 || $4>50')
if [[ ! -z "$HIGH_USAGE" ]]; then
    echo "Processes with high CPU or memory usage:" >> $REPORT
    echo "$HIGH_USAGE" >> $REPORT
    echo "<li>High Resource Usage:</li><pre>$HIGH_USAGE</pre>" >> $HTML_REPORT
else
    echo "No processes found with high resource usage." >> $REPORT
    echo "<li>No processes found with high resource usage.</li>" >> $HTML_REPORT
fi

# Root processes that are unusual
ROOT_PROCESSES=$(ps aux | awk '$1=="root" && $11 !~ "sshd|systemd|bash|/usr/sbin/"')
if [[ ! -z "$ROOT_PROCESSES" ]]; then
    echo "Unusual processes running as root:" >> $REPORT
    echo "$ROOT_PROCESSES" >> $REPORT
    echo "<li>Unusual Root Processes:</li><pre>$ROOT_PROCESSES</pre>" >> $HTML_REPORT
else
    echo "No unusual processes running as root." >> $REPORT
    echo "<li>No unusual processes running as root.</li>" >> $HTML_REPORT
fi
echo "</ul>" >> $HTML_REPORT

# Monitor Network Activity
echo "[+] Monitoring Network Activity..."
echo "Network Activity:" >> $REPORT
echo "<h2>Network Activity</h2><ul>" >> $HTML_REPORT

# Display active connections
ACTIVE_CONNECTIONS=$(netstat -tuln)
if [[ ! -z "$ACTIVE_CONNECTIONS" ]]; then
    echo "Active Connections:" >> $REPORT
    echo "$ACTIVE_CONNECTIONS" >> $REPORT
    echo "<li>Active Connections:</li><pre>$ACTIVE_CONNECTIONS</pre>" >> $HTML_REPORT
else
    echo "No active connections found." >> $REPORT
    echo "<li>No active connections found.</li>" >> $HTML_REPORT
fi

# Check for suspicious external connections
SUSPICIOUS_CONNECTIONS=$(netstat -an | grep ESTABLISHED | awk '$5 !~ /127.0.0.1/ && $5 !~ /::1/')
if [[ ! -z "$SUSPICIOUS_CONNECTIONS" ]]; then
    echo "Suspicious External Connections:" >> $REPORT
    echo "$SUSPICIOUS_CONNECTIONS" >> $REPORT
    echo "<li>Suspicious External Connections:</li><pre>$SUSPICIOUS_CONNECTIONS</pre>" >> $HTML_REPORT
else
    echo "No suspicious external connections found." >> $REPORT
    echo "<li>No suspicious external connections found.</li>" >> $HTML_REPORT
fi
echo "</ul>" >> $HTML_REPORT

# Advanced Security Vulnerability Detection
echo "[+] Running Advanced Security Vulnerability Detection..."
echo "Advanced Security Vulnerability Detection:" >> $REPORT
echo "<h2>Advanced Security Vulnerability Detection</h2><ul>" >> $HTML_REPORT

# Run Lynis for system auditing
if command -v lynis &>/dev/null; then
    echo "[*] Running Lynis system audit..." >> $REPORT
    echo "<li>Running Lynis system audit:</li>" >> $HTML_REPORT
    LYNIS_RESULTS=$(lynis audit system --quick 2>/dev/null | tail -n 20)
    echo "$LYNIS_RESULTS" >> $REPORT
    echo "<pre>$LYNIS_RESULTS</pre>" >> $HTML_REPORT
else
    echo "Lynis not installed or not found in PATH." >> $REPORT
    echo "<li>Lynis not installed or not found in PATH.</li>" >> $HTML_REPORT
fi

# Check SSH configuration for weaknesses
echo "[*] Analyzing SSH configuration..." >> $REPORT
echo "<li>Analyzing SSH configuration:</li>" >> $HTML_REPORT
if [ -f /etc/ssh/sshd_config ]; then
    WEAK_SSH_CONFIG=$(grep -Ei "PermitRootLogin yes|PasswordAuthentication yes" /etc/ssh/sshd_config)
    if [[ ! -z "$WEAK_SSH_CONFIG" ]]; then
        echo "Weak SSH configurations detected:" >> $REPORT
        echo "$WEAK_SSH_CONFIG" >> $REPORT
        echo "<pre>Weak SSH configurations detected: $WEAK_SSH_CONFIG</pre>" >> $HTML_REPORT
    else
        echo "No weak SSH configurations found." >> $REPORT
        echo "<li>No weak SSH configurations found.</li>" >> $HTML_REPORT
    fi
else
    echo "SSH configuration file not found." >> $REPORT
    echo "<li>SSH configuration file not found.</li>" >> $HTML_REPORT
fi

echo "[+] Analyzing System Logs..."
echo "Log Analysis:" >> $REPORT
echo "<h2>Log Analysis</h2><ul>" >> $HTML_REPORT

LOG_FILES=("/var/log/syslog" "/var/log/messages" "/var/log/auth.log")

for log_file in "${LOG_FILES[@]}"; do
    if [ -f "$log_file" ]; then
        echo "[*] Analyzing $log_file..." >> $REPORT
        echo "<li>Analyzing $log_file:</li>" >> $HTML_REPORT

        # Extract errors and warnings
        ERRORS=$(grep -i 'error' "$log_file" | tail -n 10)
        WARNINGS=$(grep -i 'warning' "$log_file" | tail -n 10)

        if [[ ! -z "$ERRORS" ]]; then
            echo "Errors:" >> $REPORT
            echo "$ERRORS" >> $REPORT
            echo "<li>Errors:</li><pre>$ERRORS</pre>" >> $HTML_REPORT
        else
            echo "No errors found in $log_file." >> $REPORT
            echo "<li>No errors found in $log_file.</li>" >> $HTML_REPORT
        fi

        if [[ ! -z "$WARNINGS" ]]; then
            echo "Warnings:" >> $REPORT
            echo "$WARNINGS" >> $REPORT
            echo "<li>Warnings:</li><pre>$WARNINGS</pre>" >> $HTML_REPORT
        else
            echo "No warnings found in $log_file." >> $REPORT
            echo "<li>No warnings found in $log_file.</li>" >> $HTML_REPORT
        fi
    else
        echo "$log_file not found." >> $REPORT
        echo "<li>$log_file not found.</li>" >> $HTML_REPORT
    fi
done

echo "</ul>" >> $HTML_REPORT

# File Integrity Monitoring
echo "[+] Checking File Integrity..."
echo "File Integrity Monitoring:" >> $REPORT
echo "<h2>File Integrity Monitoring</h2><ul>" >> $HTML_REPORT

# Define files to monitor
FILES_TO_MONITOR=("/etc/passwd" "/etc/shadow" "/etc/hosts")
INTEGRITY_REFERENCE="file_integrity_reference.txt"

# Generate or compare file hashes
if [ ! -f "$INTEGRITY_REFERENCE" ]; then
    echo "[*] Creating initial integrity reference file..."
    for file in "${FILES_TO_MONITOR[@]}"; do
        if [ -f "$file" ]; then
            sha256sum "$file" >> "$INTEGRITY_REFERENCE"
            echo "<li>Initial hash recorded for $file</li>" >> $HTML_REPORT
        else
            echo "$file not found." >> $REPORT
            echo "<li>$file not found.</li>" >> $HTML_REPORT
        fi
    done
    echo "Integrity reference file created: $INTEGRITY_REFERENCE" >> $REPORT
else
    echo "[*] Comparing file hashes with reference..."
    while read -r line; do
        HASH=$(echo "$line" | awk '{print $1}')
        FILE=$(echo "$line" | awk '{print $2}')
        if [ -f "$FILE" ]; then
            CURRENT_HASH=$(sha256sum "$FILE" | awk '{print $1}')
            if [ "$HASH" != "$CURRENT_HASH" ]; then
                echo "WARNING: Integrity check failed for $FILE" >> $REPORT
                echo "<li>WARNING: Integrity check failed for $FILE</li>" >> $HTML_REPORT
            else
                echo "Integrity check passed for $FILE" >> $REPORT
                echo "<li>Integrity check passed for $FILE</li>" >> $HTML_REPORT
            fi
        else
            echo "$FILE not found during integrity check." >> $REPORT
            echo "<li>$FILE not found during integrity check.</li>" >> $HTML_REPORT
        fi
    done < "$INTEGRITY_REFERENCE"
fi

echo "</ul>" >> $HTML_REPORT

# User Privilege Analysis
echo "[+] Analyzing User Privileges..."
echo "User Privilege Analysis:" >> $REPORT
echo "<h2>User Privilege Analysis</h2><ul>" >> $HTML_REPORT

# Users with sudo privileges
SUDO_USERS=$(getent group sudo | cut -d: -f4)
if [[ ! -z "$SUDO_USERS" ]]; then
    echo "Users with sudo privileges: $SUDO_USERS" >> $REPORT
    echo "<li>Users with sudo privileges: $SUDO_USERS</li>" >> $HTML_REPORT
else
    echo "No users with sudo privileges found." >> $REPORT
    echo "<li>No users with sudo privileges found.</li>" >> $HTML_REPORT
fi

# Users with no password
echo "[*] Checking for users with no password..." >> $REPORT
echo "<li>Checking for users with no password:</li>" >> $HTML_REPORT
NO_PASSWORD_USERS=$(awk -F: '($2 == "" || $2 == "*") { print $1 }' /etc/shadow)
if [[ ! -z "$NO_PASSWORD_USERS" ]]; then
    echo "Users with no password: $NO_PASSWORD_USERS" >> $REPORT
    echo "<pre>Users with no password: $NO_PASSWORD_USERS</pre>" >> $HTML_REPORT
else
    echo "All users have passwords set." >> $REPORT
    echo "<li>All users have passwords set.</li>" >> $HTML_REPORT
fi

# Users with open home directories
echo "[*] Checking for open home directories..." >> $REPORT
echo "<li>Checking for open home directories:</li>" >> $HTML_REPORT
OPEN_HOME_USERS=$(find /home -type d -perm /o+w 2>/dev/null | awk -F/ '{print $3}')
if [[ ! -z "$OPEN_HOME_USERS" ]]; then
    echo "Users with open home directories: $OPEN_HOME_USERS" >> $REPORT
    echo "<pre>Users with open home directories: $OPEN_HOME_USERS</pre>" >> $HTML_REPORT
else
    echo "No users with open home directories found." >> $REPORT
    echo "<li>No users with open home directories found.</li>" >> $HTML_REPORT
fi

echo "</ul>" >> $HTML_REPORT

# Finalize HTML report
echo "</body></html>" >> $HTML_REPORT

# Output
echo "Dashboard report generated:"
echo "  - Text report: $REPORT"
echo "  - HTML report: $HTML_REPORT"
