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

# Analyze System Logs
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

# Finalize HTML report
echo "</body></html>" >> $HTML_REPORT

# Output
echo "Dashboard report generated:"
echo "  - Text report: $REPORT"
echo "  - HTML report: $HTML_REPORT"
