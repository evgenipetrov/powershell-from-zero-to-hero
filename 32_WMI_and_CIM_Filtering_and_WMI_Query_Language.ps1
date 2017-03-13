<# 32. FILTERING AND WMI QUERY LANGUAGE #>

## 1. Specifying filter criteria

# PS 2.0:
Get-WmiObject -Class win32_service -ComputerName DC

# let us filter it. what is wrong with this query?
Get-WmiObject -Class win32_service -ComputerName dc | Where-Object {$_.State -ne 'Running' -and $_.StartMode -eq 'Auto'}

# let us try to move the filtering to the left
help Get-WmiObject -Parameter Filter

# using internal filter for wmi. note the specifics
Get-WmiObject -Class win32_service -Filter 'Name LIKE "Win%"'

# rewrite the above example filtering to the left
Get-WmiObject -Class win32_service -ComputerName dc -Filter " state <> 'running' and startmode = 'auto' "

# do a filter with wildcard
Get-WmiObject -Class win32_service -ComputerName member -Filter " name like 'remote%' "

## 2. Using WQL queries

# example 
$wql = 'SELECT * from win32_logicaldisk WHERE drivetype = 3'
Get-WmiObject -Query $wql

# it can work against remote computers too
Get-WmiObject -Query $wql -ComputerName member.lab.pri

# try with CIM 
Get-CimInstance -ClassName Win32_Service -ComputerName member -Filter "startmode = 'auto' and name like 'remote%' and state <> 'running'" | Format-Table -AutoSize

# WQL example with CIM
Get-CimInstance -ComputerName member -Query "SELECT * FROM win32_service WHERE startmode = 'auto' AND name LIKE 'remote%' AND state <> 'running'"

