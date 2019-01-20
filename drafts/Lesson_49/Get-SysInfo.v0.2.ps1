param(
    [string]$ComputerName
)

$os = Get-WmiObject -Class win32_operatingsystem -ComputerName $ComputerName
$bios = Get-WmiObject -Class win32_bios -ComputerName $ComputerName

$props = @{ 'ComputerName'=$ComputerName;
            'OSVersion'=$os.Version;
            'SPVersion'=$os.servicepackmajorversion;
            'BIOSSerial'=$bios.serialnumber;
         }

$object = New-Object -TypeName PSObject -Property $props
Write-Output $object