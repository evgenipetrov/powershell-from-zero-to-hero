$commonPassword = 'demo!234'

$computename = 'SQL'

$IPv4Address = '192.168.10.3'
$prefixLength = '24'
$dns = '192.168.10.2'

$domainName = 'LAB.PRI'
$domainNetbiosName = 'LAB'


Import-Module -Name C:\Projects\powershell-module-labtools\LabTools\LabTools.psd1 -Force -Verbose

Rename-LabComputer -NewName $computename
Set-LabNetAddress -IPv4Address $IPv4Address -PrefixLength $prefixLength -DNS $dns



 