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

# Finalize HTML report
echo "</body></html>" >> $HTML_REPORT

# Output
echo "Dashboard report generated:"
echo "  - Text report: $REPORT"
echo "  - HTML report: $HTML_REPORT"
