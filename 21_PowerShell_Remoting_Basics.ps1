<# 00. POWERSHELL REMOTING BASICS #>

## 1. How it works

# Protocol
# WS-MAN - web services for management. WinRM. HTTP(S). 5985 / 5986

# Interactive usage - 1:1
# One to many - 1:n

## 2. Enabling manually

# enable it with PowerShell command
Enable-PSRemoting

# enable it with CMD 
winrm quickconfig

## 3. Enabling via GPO

# location: Computer Configuration > Policies > Administrative Templates > Windows Components > Windows Remote Management > WinRM Service
# filters

# set WinRM service to automatic. This will not start the service. How can we start it immediately?
# location: Computer Configuration > Policies > Windows Settings > Security Settings > System Services > Windows Remote Management

# configure a firewall exception.
# location: Computer Configuration > Windows Settings > Administrative Templates > Network > Network Connections > Windows Firewall > Domain Profile > Windows Firewall: Allow local port exceptions. / Windows Firewall: Define inbound Port Exceptions > Port 5985


## 4. Basic usage

