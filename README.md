# Automated System Health Monitoring Script

## 📌 Overview
This PowerShell script automates daily system health checks for Windows machines.  
It generates a log file containing information about disk usage, network connectivity, firewall status, and antivirus protection.

## 🔧 Features
- Monitors **disk usage** and alerts on low free space.
- Tests **network connectivity** with common hosts (Google DNS, Cloudflare, etc.).
- Checks **firewall status** across profiles.
- Retrieves **antivirus product information**.
- Logs results with **timestamps** for tracking and troubleshooting.

## 🚀 How to Use
1. Clone this repository or download the script.
2. Save the script as `SystemHealthCheck.ps1`.
3. Open PowerShell as **Administrator**.
4. Navigate to the script location and run:
   ```powershell
   .\SystemHealthCheck.ps1

Check the output log at:

C:\IT_Support\SystemHealthLog.txt

⚡ Automation

You can schedule this script to run daily using Windows Task Scheduler:

Program: powershell.exe

Arguments:

-ExecutionPolicy Bypass -File "C:\IT_Support\SystemHealthCheck.ps1"

📂 Sample Log Output
===============================
System Health Report - 2025-09-19 10:45:23
===============================

[Disk Usage]
Drive C: 45 GB free of 120 GB (37.5% free)

[Network Connectivity]
Ping to 8.8.8.8: Success
Ping to 1.1.1.1: Success
Ping to google.com: Success

[Firewall Status]
Profile: Domain, Enabled: True
Profile: Private, Enabled: True
Profile: Public, Enabled: True

[Antivirus Status]
Windows Defender : 397568

Report completed.

📜 License

This project is open-source and available under the MIT License.
