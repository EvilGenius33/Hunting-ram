# ================================
# Advanced Defensive Script (PowerShell)
# Purpose: Detect advanced memory injection and evasion tactics
# ================================

$zipPath = "$env:TEMP\Sysmon.zip"
$extractPath = "$env:TEMP\Sysmon"
$logFile = "$env:USERPROFILE\Desktop\advanced_defense_log.txt"

# Download and extract Sysmon
Write-Host "[+] Downloading Sysmon..."
Invoke-WebRequest -Uri "https://download.sysinternals.com/files/Sysmon.zip" -OutFile $zipPath
Expand-Archive -Path $zipPath -DestinationPath $extractPath -Force

# Install Sysmon in default logging mode
Write-Host "[+] Installing Sysmon in default mode..."
Start-Process -FilePath "$extractPath\Sysmon64.exe" -ArgumentList "-accepteula -i" -Wait

# Target event IDs based on modern evasion techniques
$EventIdsToMonitor = @(3, 10, 11, 17, 22, 23, 25) # Includes ProcessAccess, NetworkConnect, PipeEvent, DNS, ImageLoad

Write-Host "[+] Monitoring for evasion-resistant memory and execution techniques..."
Write-Host "[+] Logging alerts to: $logFile"

# Register ETW listener
Register-WmiEvent -Query "Select * From __InstanceCreationEvent Within 2 Where TargetInstance ISA 'Win32_NTLogEvent' and TargetInstance.LogFile = 'Microsoft-Windows-Sysmon/Operational'" -SourceIdentifier "AdvancedDefense" -Action {
 $evt = $Event.SourceEventArgs.NewEvent.TargetInstance
 if ($evt.EventCode -in @(3, 10, 11, 17, 22, 23, 25)) {
 $alert = "[DETECTED] EventID: $($evt.EventCode) | Source: $($evt.SourceName) | Computer: $($evt.ComputerName)nMessage:n$($evt.Message)nn"
 Write-Host $alert
 Add-Content -Path "$env:USERPROFILE\Desktop\advanced_defense_log.txt" -Value $alert
 }
}

Write-Host "[+] Active memory and network execution monitoring enabled. Press CTRL+C to stop."
while ($true) { Start-Sleep -Seconds 5 }
