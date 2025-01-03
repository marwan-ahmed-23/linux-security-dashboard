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

# Finalize HTML report
echo "</body></html>" >> $HTML_REPORT

# Output
echo "Dashboard report generated:"
echo "  - Text report: $REPORT"
echo "  - HTML report: $HTML_REPORT"
