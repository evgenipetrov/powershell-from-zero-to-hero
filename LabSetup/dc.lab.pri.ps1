$computename = 'DC'

$IPv4Address = '192.168.10.2'
$prefixLength = '24'
$dns = '192.168.10.2'



Import-Module -Name $PSScriptRoot\..\LabTools\LabTools.psd1 -Force -Verbose

Rename-LabComputer -NewName $computename
Set-LabNetAddress -IPv4Address $IPv4Address -PrefixLength $prefixLength -DNS $dns
Install-LabWindowsServerFeature -Name 'AD-Domain-Services'




