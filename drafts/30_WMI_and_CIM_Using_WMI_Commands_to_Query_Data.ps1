<# 30. USING WMI COMMANDS TO QUERY DATA #>

## 1. Getting WMI objects

# get objects
Get-WmiObject -Class win32_service

## 2. They are objects!

# see all the properties. 
Get-WmiObject -Class win32_service | Select-Object -First 1 -Property *

# compare to get-service cmdlet output
Get-Service | Select-Object -First 1 -Property *

# short version
gwmi win32_bios

## 3. Other computers and credentials

# target multiple computers. note the slowness. note the query is sequential
gwmi -ComputerName dc,member,localhost -Class win32_bios

# target multiple targets. note the actual machine name is not listed in the error.
gwmi -ComputerName dc,nonexisting,localhost -Class win32_bios

# why this is even slower?
gwmi -ComputerName dc,member,localhost -Class win32_bios | Format-Table -AutoSize

# PSComputername property. Only PS version 3.0
gwmi -ComputerName dc,nonexisting,localhost -Class win32_bios | gm

# querying other namespaces
gwmi -Class AntiSpywareProduct
gwmi -Class AntiSpywareProduct -Namespace root\securitycenter2

# passing credentials. note the error with local connection
gwmi -Class win32_operatingsystem -ComputerName client,dc -Credential lab\administrator

# help on the get-wmiobjest
help Get-WmiObject -Full

# sometimes the documentation is useful to decode the WMI object values
gwmi -Class win32_logicaldisk

## 4. Working with property values

# PowerShell adds its own methods to the major core WMI classes
$os = Get-WmiObject -Class win32_operatingsystem
$os.LastBootUpTime
$os.ConvertToDateTime($os.LastBootUpTime)

