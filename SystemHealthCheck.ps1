$logPath = "C:\IT_Support\SystemHealthLog.txt"
if (!(Test-Path -Path "C:\IT_Support")) {
    New-Item -ItemType Directory -Path "C:\IT_Support"
}

$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Add-Content -Path $logPath -Value "==============================="
Add-Content -Path $logPath -Value "System Health Report - $timestamp"
Add-Content -Path $logPath -Value "==============================="

Add-Content -Path $logPath -Value "`n[Disk Usage]"
Get-PSDrive -PSProvider 'FileSystem' | ForEach-Object {
    $freeGB = [math]::Round($_.Free/1GB,2)
    $usedGB = [math]::Round(($_.Used)/1GB,2)
    $totalGB = [math]::Round($_.Used/1GB + $_.Free/1GB,2)
    $percentFree = [math]::Round(($_.Free / ($_.Used + $_.Free)) * 100, 2)

    $result = "Drive {0}: {1} GB free of {2} GB ({3}% free)" -f $_.Name, $freeGB, $totalGB, $percentFree
    Add-Content -Path $logPath -Value $result

    if ($percentFree -lt 20) {
        Add-Content -Path $logPath -Value "⚠ WARNING: Low disk space on drive $($_.Name)"
    }
}

Add-Content -Path $logPath -Value "`n[Network Connectivity]"
$hosts = @("8.8.8.8", "1.1.1.1", "google.com")
foreach ($host in $hosts) {
    if (Test-Connection -ComputerName $host -Count 2 -Quiet) {
        Add-Content -Path $logPath -Value "Ping to $host: Success"
    } else {
        Add-Content -Path $logPath -Value "Ping to $host: FAILED"
    }
}

Add-Content -Path $logPath -Value "`n[Firewall Status]"
$firewallState = (Get-NetFirewallProfile | Select-Object -Property Name, Enabled)
$firewallState | ForEach-Object {
    Add-Content -Path $logPath -Value ("Profile: {0}, Enabled: {1}" -f $_.Name, $_.Enabled)
}

Add-Content -Path $logPath -Value "`n[Antivirus Status]"
try {
    $av = Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntivirusProduct
    foreach ($a in $av) {
        Add-Content -Path $logPath -Value ("{0} : {1}" -f $a.displayName, $a.productState)
    }
} catch {
    Add-Content -Path $logPath -Value "Could not retrieve antivirus status."
}

Add-Content -Path $logPath -Value "`nReport completed.`n"
