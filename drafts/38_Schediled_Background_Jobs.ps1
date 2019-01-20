<# 38. SCHEDULED BACKGROUND JOBS #>

## 1. Overview - Scheduled JOBS vs Scheduled TASKS 

# we will not be working with module ScheduledTasks
Get-Command -Module ScheduledTasks

# we will be working with PSScheduledJobs. Version 3.0 only
Get-Command -Module PSScheduledJob

## 2. Triggers

# see the help for job triggers. note the parameter sets are separated by some sort of a schedule. note the logon and startup script replacement.
help New-JobTrigger -Full

# set up a sample trigger
$trigger = New-JobTrigger -AtLogOn

# see the trigger
$trigger
$trigger | gm

## 3. Options

# see the options
Get-Help New-ScheduledJobOption -Full 

# let us put a sample iotion
$option = New-ScheduledJobOption -RequireNetwork -WakeToRun

# see the option object
$option

## 4. Registering Jobs

# see the help for registering jobs
help Register-ScheduledJob

# try to register a job
Register-ScheduledJob -Name "get processes at logon" -ScriptBlock { Get-Process } -MaxResultCount 2 -Trigger $trigger -ScheduledJobOption $option

# check the jobs
Get-ScheduledJob

# see the members. JobTriggers and UpdateOptions are accessible
Get-ScheduledJob | gm
Get-ScheduledJob | Select-Object -ExpandProperty JobTriggers
Get-ScheduledJob | Select-Object -ExpandProperty Options

# see the scheduled tasks and locate our tasks
taskschd.msc

# there is a new parameter in PS v4.0 -RunNow

#logoff
logoff


# see if there are any jobs
Get-Job

# import the module and try again. note there is no "more data" flag
Import-Module PSScheduledJob
Get-Job

# check the scheduled jobs
Get-ScheduledJob

# receive the data and keep it cached
Receive-Job -Id 2 -Keep

# try same in another shell
Get-Job
Receive-Job -Id 2

## 5. Working with jobs that have run

# where is the disk file located?
Get-ScheduledJob | fl *

# let us check it
cd 'C:\Users\administrator\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs'
dir
cd 'C:\Users\administrator\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs\get processes at logon'
dir






































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

