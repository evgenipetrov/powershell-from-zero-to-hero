<# 27. WEB REMOTING POWERSHELL WEB ACCESS #>

## 1. Installation and setup

# let us install the feature on the member server
Enter-PSSession -ComputerName member.lab.pri
Add-WindowsFeature -Name WindowsPowerShellWebAccess

# let us look at the modules
Get-Command -Module PowerShellWebAccess

# install PowerShell web access application with a test certificate
Install-PswaWebApplication -UseTestCertificate 

# at this point you may get iexcited
exit
start iexplore.exe http://member.lab.pri/pswa

# adding an authorization rule. hitting the double hop issue
Add-PswaAuthorizationRule -RuleName 'Default config for admins' -ConfigurationName 'microsoft.powershell' -UserGroupName 'lab\domain admins' -ComputerName 'dc.lab.pri'

# enable CredSSP
exit
Enable-WSManCredSSP -Role Client -DelegateComputer *.lab.pri

# try make a new session using CredSSP
# make a new session using CredSSP
exit
Enter-PSSession -ComputerName member.lab.pri -Authentication Credssp -Credential lab\administrator

# enable the server part
Invoke-Command -ComputerName member.lab.pri -ScriptBlock { Enable-WSManCredSSP -Role Server }

# make a new session using CredSSP
exit
Enter-PSSession -ComputerName member.lab.pri -Authentication Credssp -Credential lab\administrator

## 2. Use PowerShell Web Access
exit
start iexplore.exe https://member.lab.pri/pswa

