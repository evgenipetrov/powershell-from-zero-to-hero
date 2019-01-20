<# 39. JOBS REVIEW #>

## 1. Create a text file with 1 computer per line. Use WMI or CIM to get the services that are not running and are set on autorun from these computers. Then enchance the command to do this as a job. Dislplay the results from the job on the screen. Export the results as csv. If a job hs failed - find out why.

## 2. do the above and receive the output immediately after the first job completes in one command (line)




































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

