<# 47. FROM COMMAND TO SCRIPT TO MODULE #>

## 1. Write a command

# pick a command
Get-EventLog -LogName Security -Newest 50 -ComputerName dc.lab.pri

# copy it to a file, give it a commandlet style name
gc -Path C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_47\Get-LatestSecurityLog.v0.1.ps1

## 2. Turn it into parametrized script

# add parameters and test it.
gc -Path C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_47\Get-LatestSecurityLog.v0.2.ps1
C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_47\Get-LatestSecurityLog.v0.2.ps1

# add another function there
gc -Path C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_47\Get-LatestSecurityLog.v0.3.ps1
C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_47\Get-LatestSecurityLog.v0.3.ps1

# now we can use them as it is with dot sourcing
. C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_47\Get-LatestSecurityLog.v0.3.ps1

## 3. Package it into module

# copy the file to a special location. pay attention how the ISE can no longer run the module file.
$env:PSModulePath

mkdir $HOME\Documents\WindowsPowerShell\Modules\MyTools
copy C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_47\Get-LatestSecurityLog.v0.3.ps1 $HOME\Documents\WindowsPowerShell\Modules\MyTools\MyTools.psm1

# try importing the module with tab completion

Import-Module myto

# try a command
Get-BiosInfo -ComputerName dc

# remove the module and try a command. What happens?
Remove-Module MyTools
Get-BiosInfo

# rememver to remove the module if you do some changes.

# try help
help Get-BiosInfo
