Write-Host 'begin'

function Get-ComputerSystemInfo {
    Get-WmiObject -Class win32_computersystem -ComputerName dc | 
        Select-Object -Property Name, Manufacturer, Model

}

Write-Host 'end'