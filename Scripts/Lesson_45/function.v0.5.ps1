function Get-ComputerSystemInfo  {
    param (
        [string]$ComputerName
    )
    Get-WmiObject -Class win32_computersystem -ComputerName $ComputerName | 
        Select-Object -Property Name, Manufacturer, Model

}

Get-ComputerSystemInfo -ComputerName dc.lab.pri 