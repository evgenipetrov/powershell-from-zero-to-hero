<# 25. ADVANCED REMOTING AND CROSSING DOMAIN BOUNDARIES #>

## 1. TrustedHosts technique

# where is the trusted hosts seting?
Set-Location -Path WSMan:\localhost\Client\
Get-ChildItem

# set the trusted hosts setting
Set-Item -LiteralPath WSMan:\localhost\Client\TrustedHosts -Value 'fdc.foreign.pri'
Set-Item -LiteralPath WSMan:\localhost\Client\TrustedHosts -Value 'fdc.foreign.pri,rdc.remote.pri'
Get-ChildItem WSMan:\localhost\Client\

# let us connect with interactive session
Enter-PSSession -ComputerName fdc.foreign.pri -Credential foreign\administrator
Get-Process
exit

# let us connect with invoke command. but what credential to provide?
Set-Item -LiteralPath WSMan:\localhost\Client\TrustedHosts -Value '*'
Invoke-Command -ScriptBlock {
  Get-EventLog -LogName System -Newest 10
} -ComputerName fdc.foreign.pri, member.lab.pri, rdc.remote.pri

Invoke-Command -ScriptBlock {
  Get-EventLog -LogName System -Newest 10
} -ComputerName fdc.foreign.pri, member.lab.pri, rdc.remote.pri

## 2. SSL Technique

# certificate request
# certfiicate installation
# trust installation

# we are remoting the insecure way, just for the sake of the tutorial
Enter-PSSession -ComputerName fdc.foreign.pri -Credential foreign\administrator

# verify the certificates
cd Cert:\LocalMachine
ls -Recurse

# HTTPS listener

# in order to create the HTTPS listener we need to grab the SSL Thumbprint first
$thumbprint=(Get-ChildItem -Path Cert:\LocalMachine\My | Where-Object {$_.Subject -like "cn=fdc.foreign.pri"} | Select-Object -First 1).Thumbprint

# set the listener. open port 5986 if needed. 
New-WSManInstance -ResourceURI winrm/config/listener -SelectorSet @{Address='*';Transport='HTTPS'} -ValueSet @{Hostname='fdc.foreign.pri';CertificateThumbprint=$thumbprint}

# install the certificate on the local machine
mmc.exe

# remove the trusted hosts entry just in case
Set-Item WSMan:\localhost\Client\TrustedHosts -Value ''

# test
Enter-PSSession -ComputerName fdc.foreign.pri

# test with SSL
Enter-PSSession -ComputerName fdc.foreign.pri -UseSSL -Credential foreign\administrator

# test with SSL and session options
$sessionOption = New-PSSessionOption -SkipRevocationCheck
Enter-PSSession -ComputerName fdc.foreign.pri -UseSSL -Credential foreign\administrator -SessionOption $sessionOption