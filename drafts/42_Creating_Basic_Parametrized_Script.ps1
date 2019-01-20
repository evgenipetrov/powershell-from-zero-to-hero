<# 41. CREATING BASIC PARAMETRIZED SCRIPT #>

## 1. Testing a command

# let us run a simple command
Get-WmiObject -Class win32_logicaldisk -Filter "DriveType=3"

# look for PSComputerName property
gwmi win32_logicaldisk -Filter "DriveType=3" | select -Property *

# keep the code compatible and change the ugly __SERVER output
gwmi win32_logicaldisk -Filter "DriveType=3" | select @{n='ComputerName';e={$_.__SERVER}},@{n='Drive';e={$_.DeviceId}},@{n='FreeSpace(GB)';e={$_.FreeSpace / 1GB -as [int]}},@{n='Size';e={$_.Size / 1GB -as [int]}}

# let us try to fire this off to a different computer
gwmi win32_logicaldisk -Filter "DriveType=3" -ComputerName dc.lab.pri | select @{n='ComputerName';e={$_.__SERVER}},@{n='Drive';e={$_.DeviceId}},@{n='FreeSpace(GB)';e={$_.FreeSpace / 1GB -as [int]}},@{n='Size';e={$_.Size / 1GB -as [int]}}

# now we have the command. let us make it most readable
Get-WmiObject -Class win32_logicaldisk -Filter "DriveType=3" | 
    Select-Object -Property @{n='ComputerName';e={$_.__SERVER}},
                            @{n='Drive';e={$_.DeviceId}},
                            @{n='FreeSpace(GB)';e={$_.FreeSpace / 1GB -as [int]}},
                            @{n='Size';e={$_.Size / 1GB -as [int]}}

## 2. Adding a command to a sctipt 

# save it to disk - .\Scripts\Lesson_42\Get-DiskInfo.ps1

## 3. Identifying changeable information

# candidate #1 - ComputerName. Mind the case and mind the identation. Any other good candidates? Are they good for any default values? (optional)
param(
    [string]$ComputerName
)

## 4. Parametrizing the changeable bits

# see Get-DiskInfo.v2.ps1

# try tab completion. check the positional parameters.
C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_42\Get-DiskInfo.v0.2.ps1 -ComputerName dc.lab.pri 3

# try to change the input data type 
C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_42\Get-DiskInfo.v0.2.ps1 -ComputerName dc.lab.pri -DriveType Fixed

## 5. Testing the parametrized script

# try to format it
C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_42\Get-DiskInfo.v0.2.ps1 -ComputerName dc.lab.pri 3 | Format-Table

# try to export it to csv
C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_42\Get-DiskInfo.v0.2.ps1 -ComputerName dc.lab.pri 3 | Export-Csv DiskInfo.csv
Get-Content .\DiskInfo.csv

# what if we ask for help?
help C:\Users\administrator> C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_42\Get-DiskInfo.v0.2.ps1

# try to run it without parameters. How can we mitigate the error
C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_42\Get-DiskInfo.v0.2.ps1

# improve it even more asking the user about the non default parameter.
C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_42\Get-DiskInfo.v0.3.ps1 -ComputerName member