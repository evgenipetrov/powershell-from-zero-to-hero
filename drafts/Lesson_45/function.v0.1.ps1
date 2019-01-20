Get-WmiObject -Class win32_computersystem -ComputerName dc | 
    Select-Object -Property Name, Manufacturer, Model