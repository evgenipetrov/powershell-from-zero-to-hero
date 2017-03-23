param(
    [string[]]$ComputerName
)

foreach($computer in $ComputerName){
    $os = Get-WmiObject -Class win32_operatingsystem -ComputerName $computer
    $bios = Get-WmiObject -Class win32_bios -ComputerName $computer

    $props = @{ 'ComputerName'=$computer;
                'OSVersion'=$os.Version;
                'SPVersion'=$os.servicepackmajorversion;
                'BIOSSerial'=$bios.serialnumber;
             }

    $object = New-Object -TypeName PSObject -Property $props
    Write-Output $object
}

