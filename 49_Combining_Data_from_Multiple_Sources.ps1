<# 49. COMBINING DATA FROM MULTIPLE SOURCES #>

## 1. One script - one pipeline

# pick commands
Get-WmiObject -Class win32_operatingsystem -ComputerName dc.lab.pri
Get-WmiObject -Class win32_bios -ComputerName dc.lab.pri

# save them to a file and parametrize
gc -Path C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_49\Get-SysInfo.v0.1.ps1

# try to run it and see the output. any potential issues?
C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_49\Get-SysInfo.v0.1.ps1 -ComputerName dc.lab.pri

# try to export to csv
C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_49\Get-SysInfo.v0.1.ps1 -ComputerName dc.lab.pri | Export-Csv -Path c:\export.scv
notepad c:\export.scv
Import-Csv -Path c:\export.scv

# compare the command and the script's output objects members
$ComputerName = dc.lab.pri
Get-WmiObject -Class win32_operatingsystem -ComputerName $ComputerName | gm
Get-WmiObject -Class win32_bios -ComputerName $ComputerName | gm

C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_49\Get-SysInfo.v0.1.ps1 -ComputerName dc.lab.pri | gm

## 2. Making custom output objects

# change the script in a way to combine them and make a new object
C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_49\Get-SysInfo.v0.2.ps1 -ComputerName dc.lab.pri | gm

# now we can work normally with our custom objects
C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_49\Get-SysInfo.v0.2.ps1 -ComputerName dc.lab.pri | Format-Table
C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_49\Get-SysInfo.v0.2.ps1 -ComputerName dc.lab.pri | Export-Csv c:\export2.csv

# make it work with multiple computers
gc -Path C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_49\Get-SysInfo.v0.3.ps1
C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_49\Get-SysInfo.v0.3.ps1 -ComputerName dc, client

# let us make a module
gc -Path C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_49\Get-SysInfo.psm1

# import module from an unusual location
Import-Module C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_49\Get-SysInfo.psm1
Get-SysInfo -ComputerName dc,localhost,client

## 3. Preserving property order

# ordered hashtables
$computer = 'dc'

$os = Get-WmiObject -Class win32_operatingsystem -ComputerName $computer
$bios = Get-WmiObject -Class win32_bios -ComputerName $computer

$props = [ordered]@{ 'ComputerName'=$computer;
            'OSVersion'=$os.Version;
            'SPVersion'=$os.servicepackmajorversion;
            'BIOSSerial'=$bios.serialnumber;
            }

$object = New-Object -TypeName PSObject -Property $props
Write-Output $object

# the better way to order them - compatible with v2.0
$computer = 'dc'

$os = Get-WmiObject -Class win32_operatingsystem -ComputerName $computer
$bios = Get-WmiObject -Class win32_bios -ComputerName $computer

$props = [ordered]@{ 'ComputerName'=$computer;
            'OSVersion'=$os.Version;
            'SPVersion'=$os.servicepackmajorversion;
            'BIOSSerial'=$bios.serialnumber;
            }

$object = New-Object -TypeName PSObject -Property $props
Write-Output $object | Select-Object SPVersion, OSVersion, ComputerName