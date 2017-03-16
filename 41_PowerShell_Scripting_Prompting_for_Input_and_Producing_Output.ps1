<# 41. PROMPTING FOR INPUT AND PRODUCING OUTPUT #>

## 0. Preparation

Set-ExecutionPolicy -ExecutionPolicy Restricted

## 1. Running scripts

# see the sample.ps1 script. try to open it.

# try to copy paste the content in the PowerShell console

## 2. Filename extension association

# try to right click it and run it

# try to run it from the console. note that to run scripts in the console you always have to use some form of path.

# what is a certificate authority? what is class 3 certificate?

# how do you sign a script?
Get-Help Set-AuthenticodeSignature -Full

# see an example of a signature
Get-Content C:\Windows\System32\WindowsPowerShell\v1.0\DotNetTypes.format.ps1xml

# see the signature itself
Get-AuthenticodeSignature C:\Windows\System32\WindowsPowerShell\v1.0\DotNetTypes.format.ps1xml | Format-List -Property *

## 3. Execution policy

# See the execution policy
help Set-ExecutionPolicy

# what are the defaults?
# before server 2012 - Restricted
# after server 2012 - RemoteSigned

# any user can run CMD with any policy
cmd.exe /c "powershell.exe -ExecutionPolicy Bypass"
Get-ExecutionPolicy
exit
Get-ExecutionPolicy
































## Answers

# 1.
Get-WmiObject -Class win32_logicaldisk -Filter "drivetype=3"
# 2.
Get-CimInstance -ClassName win32_process -ComputerName client,dc
# 3.
Get-WmiObject -Class win32_nteventlogfile -Filter "logfilename='system'" -EnableAllPrivileges -ComputerName win7.lab.pri | Invoke-WmiMethod -Name BackupEventLog -ArgumentList c:\backup.evt
# 4. 
$win7 = New-CimSession -ComputerName win7.lab.pri -SessionOption (New-CimSessionOption -Protocol Dcom)
Get-CimInstance -CimSession $win7 -ClassName win32_bios

