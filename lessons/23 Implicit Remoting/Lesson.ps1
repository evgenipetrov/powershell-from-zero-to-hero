## Start a session
# load a module into memory
# create shortcuts to that module
# on local computer.

Enter-PSSession -ComputerName dc.lab.pri
Enter-PSSession -ComputerName -rdc.remote.pri -Credential remote\administrator

Get-Module
Get-Module -ListAvailable

$dcSession = New-PSSession -ComputerName dc.lab.pri
$rdcSession = New-PSSession -ComputerName rdc.remote.pri -Credential remote\administrator

Invoke-Command -Session $dc,$rdc -ScriptBlock { Import-Module ActiveDirectory }

# v2
Import-PSSession -Session $dc -Prefix LAB -Module ActiveDirectory
Import-PSSession -Session $rdc -Prefix REMOTE -Module ActiveDirectory
Import-PSSession -Session $member -Prefix MEMBER -Module WebAdministration

# v3+
Get-Module -PSSession $dcSession -ListAvailable
Import-Module -PSSession $dcSession -Name ActiveDirectory -Prefix LAB

# get objects' members. notice the objects are deserialized

# usecase - manage several versions of MS products. Like SP 2010/2013/2016
# caveates: Deserialization
get-labaduser -identity administrator | set-labaduser -department it

# pssession alternative
Enter-PSSession -ComputerName dc
get-aduser -identity administrator | set-aduser -department it

# invoke command alternative
Invoke-Command -ComputerName dc -ScriptBlock { get-aduser -identity administrator | set-aduser -department it }
Invoke-Command -Session $dcSession -ScriptBlock { get-aduser -identity administrator | set-aduser -department it }

# and another alternative
set-labaduser -identity administrator -department it



