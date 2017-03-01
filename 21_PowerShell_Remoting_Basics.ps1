<# 00. POWERSHELL REMOTING BASICS #>

## 1. How SSH works? How PowerShell Remoting works? Do they have anything in common?

# Protocol
# WS-MAN - web services for management. WinRM. HTTP(S). 5985 / 5986
# mutual authentication with same forest - Kerberos
# mutual authentication with trusted domain - Kerberos
# mutual authentication with untrusted domain - 
#       SSL
#       TrustedHosts - no mutual authentication here!

# book - https://www.gitbook.com/book/devopscollective/secrets-of-powershell-remoting/details

# Interactive usage - 1:1
Get-Help Enter-PSSession

# One to many - 1:n
Get-Help Invoke-Command

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

# check the remoting commands
Get-Command -Noun WSMan*

# check connections
cd WSMan:
dir

# connect to computer
Connect-WSMan -ComputerName dc
dir

# connect to another computer
Connect-WSMan -ComputerName member,win7 # note how ComputerName parameter does not support array of string input
Connect-WSMan -ComputerName member
Connect-WSMan -ComputerName win7

# check WSMan server configuration
cd WSman:
dir
cd .\dc
dir
cd .\Listener
dir
cd WSMan:\dc\Service\DefaultPorts
dir

# check PowerShell related configuration
cd WSMan:\dc\Shell
dir

# enter 1:1 session to a single computer
Enter-PSSession -ComputerName member.lab.pri

# run any commands
Get-Process
Get-Process | gm
exit

# execute 1:n command
Invoke-Command -ScriptBlock { Get-EventLog -LogName Security -Newest 10 } -ComputerName dc.lab.pri, member.lab.pri

# execute remotely and format locally
Invoke-Command -ScriptBlock { Get-EventLog -LogName Security -Newest 10 } -ComputerName dc.lab.pri, member.lab.pri | Format-Table -GroupBy PSComputerName # | Out-File C:\temp\remote-logs.txt

# double hop scenario
cd WSMan:\localhost\Client\Auth
dir

cd WSMan:\localhost\Service\Auth
dir

# enable delegation as client
Enable-WSManCredSSP -Role Client -DelegateComputer "*.lab.pri"

# enable targets - GPO 
# Computer Configuration > Policies > Administrative Templated > System > Credentials Delegation > Allow Delegating Fresh Credentials

# make sure to specify -Authentication for the Enter-PSSession command
Get-Help Enter-PSSession 



