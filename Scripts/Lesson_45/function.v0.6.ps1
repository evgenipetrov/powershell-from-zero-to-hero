function Get-ComputerSystemInfo  {
    param (
        [string[]]$ComputerName
    )
    
    if($input -ne $null){
        $ComputerName = $input
    }
    
    # get-wmiobject accepts array, so we are fine.
    Get-WmiObject -Class win32_computersystem -ComputerName $ComputerName | 
        Select-Object -Property Name, Manufacturer, Model

}

Get-Content C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_45\computers.txt |
    Get-ComputerSystemInfo 

# WORKS:  Get-ComputerSystemInfo -ComputerName dc.lab.pri, client.lab.pri