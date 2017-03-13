<# 34. SESSIONS #>

## 1. Managing CIM sessoins

# try to reach the RPC instance on member
Get-WmiObject -ComputerName member -Class win32_bios

# try to reach the WS-MAN instance on member
Get-CimInstance -ComputerName member -ClassName win32_bios

## 2. WSMAN and DCOM sessions

# there is a separate command related to CIM Sesison
help cimsession

# make a CIM session
$member = New-CimSession -ComputerName member.lab.pri

# check it
$member

# try to create a CIM session without using FQDN
$win7 = New-CimSession -ComputerName win7.lab.pri -SessionOption (New-CimSessionOption -Protocol Dcom)

## 3. Using session types in combination

# see what sessions do we have available
Get-CimSession

# try to query the sessions, not the computers
Get-CimInstance -ClassName Win32_OperatingSystem -CimSession $member,$win7 | Select-Object PSComputerName,Version,BuildNumber,ServicePackMajorVersion,OSArchitecture | ft

# try to query any other class
Get-CimInstance -ClassName Win32_BIOS -CimSession $win7,$member

# note the only way to get DCOM to work with CIM commands is to create a session first
help Get-CimInstance

# clean up the sessions
Get-CimSession | Remove-CimSession

# what if we need to query lots of computers?
$wsman = New-CimSession -ComputerName dc.lab.pri,member.lab.pri
$dcom = New-CimSession -ComputerName win7.lab.pri -SessionOption (New-CimSessionOption -Protocol Dcom)

# now query the machines. what is the issue here?
Get-CimInstance -ClassName Win32_ComputerSystem -CimSession $wsman,$dcom

# let us combine them
$sessions = $dcom + $wsman
$wsman += $dcom

# now execute the command again
Get-CimInstance -CimSession $wsman -ClassName win32_computersystem

# the sessions are not shared between PowerShell instances (runspaces)

# clean up
Get-CimSession | Remove-CimSession 
