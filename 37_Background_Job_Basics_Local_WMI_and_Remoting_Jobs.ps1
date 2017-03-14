<# 37. BACKGROUND JOB BASICS: WMI, LOCAL AND REMOTING JOBS #>

## 1. Local jobs

# launch a local job with a script block
Start-Job -ScriptBlock { dir c:\ -Recurse }

# the jobs can be named
Start-Job -ScriptBlock { dir c:\ -Recurse } -Name MyJobName

# see all jobs
Get-Job

# each job needs a separate powershell instance to run
Get-Process -Name powershell*

# stop a job
Stop-Job -Id 2

# check job statusese
Get-Job

# get the data from a job
Receive-Job -Id 2

# try to get it again
Receive-Job -Id 2

# check jobs again to see if job id 2 is gone.
Get-Job

# get the data out without losing it
Receive-Job -Id 3 -Keep

# remove all jobs
Get-Job | Remove-Job

## 2. Remoting jobs

# start a remote job using invoke command
Invoke-Command -ScriptBlock { Get-EventLog -LogName Security -Newest 100 } -ComputerName dc.lab.pri,member.lab.pri -AsJob -JobName MyRemoteJob

## 3. WMI jobs

# try to run a job with WMI
Get-WmiObject -Class win32_bios -ComputerName dc.lab.pri,member.lab.pri,client.lab.pri,win7.lab.pri -AsJob

# check job IDs. note there is 1 child job for each computer involved
Get-Job
Get-Job -Id 6 | Select-Object -ExpandProperty childjobs

# the job status is equal to the status of the worst state of their childjobs
Get-Job -Id 9
Get-Job -Id 9 | Select-Object -ExpandProperty childjobs

# check one of the errors 
Receive-Job -Id 10

# receive ooutput from a job and put it in a csv file
Get-Job
Receive-Job -Id 6 | Export-Csv eventlog.csv
Import-Csv -Path .\eventlog.csv | Format-Table -GroupBy PSComputerName

# cleanup
Get-Job | Remove-Job

## 4. Job management and basics

# see all job commands
Get-Command -Noun job

# wait job cmdlet.
Wait-Job -Id 4

# how many powershell instances we will get running from the following command?
Invoke-Command -ScriptBlock { Get-EventLog -LogName System -Newest 100 } -ComputerName dc.lab.pri,member.lab.pri -AsJob -JobName EventLogGetter

# how many powershell instances we will get running from the following command?
Invoke-Command -ScriptBlock { dir c:\ -recurse} -ComputerName dc.lab.pri,member.lab.pri -AsJob -JobName FilesFoldersGetter
Get-Process -Name powershell*

Invoke-Command -ScriptBlock { Get-Process -Name powershell* -ComputerName dc.lab.pri,member.lab.pri} | format-table

















































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

