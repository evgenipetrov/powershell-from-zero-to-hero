<# 28. POWERSHELL REMOTING REVIEW #>

## 1. What configuration changes are necessary to enable PS remoting. On which OS?
Enable-PSRemoting

## 2. What is double hop issue? How do you solve it?
Enable-WSManCredSSP -Role Client -DelegateComputer *.lab.pri
Enable-WSManCredSSP -Role Server

## 3. What web protocol is allowed for PowerShell web access?

## 4. Is it possible to make a custom session configuration that allows only specific users to connect? Which command?
New-PSSessionConfigurationFile

## 5. What are 2 techniques to enable PS Remoting to a machine in untrusted foreign domain?





