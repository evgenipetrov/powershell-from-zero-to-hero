$commonPassword = 'demo!234'

$computename = 'CLIENT'

$IPv4Address = '192.168.10.100'
$prefixLength = '24'
$dns = '192.168.10.2'

$domainName = 'LAB.PRI'
$domainAdminLogon = 'lab\administrator'
$domainAdminPassword = $commonPassword


Import-Module C:\Projects\powershell-module-labtools\LabTools\LabTools.psd1 -Force -Verbose

Rename-LabComputer -NewName $computename
Set-LabNetAddress -IPv4Address $IPv4Address -PrefixLength $prefixLength -DNS $dns
$secureCommonPassword = ConvertTo-SecureString -String $commonPassword -AsPlainText -Force
$credential = New-Object -TypeName System.Management.Automation.PSCredential ($domainAdminLogon, $secureCommonPassword)
Add-Computer -DomainName $domainName -Credential $credential



