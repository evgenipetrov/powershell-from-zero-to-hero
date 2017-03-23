filter Get-ComputerSystemInfo  {
    Get-WmiObject -Class win32_computersystem -ComputerName $_ | 
        Select-Object -Property Name, Manufacturer, Model
}


Get-Content C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_45\computers.txt |
    Get-ComputerSystemInfo 