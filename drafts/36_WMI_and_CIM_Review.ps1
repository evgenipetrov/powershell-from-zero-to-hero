<# 36. WMI AND CIM REVIEW #>

## 1. Write a command that uses WMI to retrieve all instances of win32_logical disk that represent FIXED local disks.

## 2. Write a command that uses CIM to retrieve all instances of win32_process and ensure that computer names appear in the output. Try to query several computers.

## 3. Write a command that connect to a computer that does not have remoting enabled using older protocol (DCOM). The command must backup the system event log file.

## 4. Write a command that uses CIM to connect to a remote computer that does not habe remoting enabled. the command must retrieve BIOS details.























































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

