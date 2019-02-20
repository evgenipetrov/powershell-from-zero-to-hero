# issues: mutual identity verification

Enter-PSSession -ComputerName fdc.foreign.pri # credential

## Trusted hosts technique
cd WSMan:\localhost\Client
Set-Item -Path WSMan:\localhost\Client\TrustedHosts -Value 'fdc.foreign.pri'
Set-Item -Path WSMan:\localhost\Client\TrustedHosts -Value '*' # not OK
Set-Item -Path WSMan:\localhost\Client\TrustedHosts -Value ''

Enter-PSSession -ComputerName fdc.foreign.pri -Credential foreign\administrator # credential is important

## SSL technique

# install the SSL on the remote machine

ls Cert:\CurrentUser\My # get the thumbprint from here
New-WSManInstance -ResourceURI wsman/config/listener -SelectorSet @{address='*'; transport='https'} -ValueSet @{hostname='fdc.foreign.pri'; certificatethumbprint='xxxxxxxx'}

Enter-PSSession -UseSSL -ComputerName fdc -Credential foreign\administrator