<# 33. ASSOCIATIONS #>

## 1. What are associations

# example documentation
start iexplore.exe 'https://msdn.microsoft.com/en-us/library/aa394061(v=vs.85).aspx'
start iexplore.exe 'https://msdn.microsoft.com/en-us/library/aa394153(v=vs.85).aspx'
start iexplore.exe 'https://msdn.microsoft.com/en-us/library/aa394151(v=vs.85).aspx'

## 2. Querying with WMI

# wmi example with network adapters. ( ID#12 on my lab.)
Get-WmiObject -Class win32_networkadapter

# now do a query to locate the references. cannot be done with a filter
Get-WmiObject -Query "references of {win32_networkadapter.deviceID=12}"

# narrow the information
Get-WmiObject -Query "references of {win32_networkadapter.deviceID=12}" | Select-Object -Property __CLASS
Get-WmiObject -Query "references of {win32_networkadapter.deviceid=12} where classdefsonly"

# query one of the classes
Get-WmiObject -Query "associators of { win32_networkadapter.deviceid = 12 } where resultclass = win32_networkadapterconfiguration"

## 3. Querying with CIM

# get the key
$disks = Get-CimInstance -ClassName win32_logicaldisk -KeyOnly

# find the relateions
Get-CimAssociatedInstance -InputObject $disks[1] -ResultClassName win32_diskpartition | fl *

# same with netadapter
$netAdapters = Get-CimInstance -ClassName win32_networkadapter -KeyOnly
Get-CimAssociatedInstance -InputObject $netAdapters[12] -ResultClassName win32_networkadapterconfiguration | fl *

# play with services
$service = Get-CimInstance -ClassName win32_service -KeyOnly -Filter "name like 'bits'"
Get-CimAssociatedInstance -InputObject $service -Association win32_dependentservice
Get-CimAssociatedInstance -InputObject $service -ResultClassName win32_dependentservice
