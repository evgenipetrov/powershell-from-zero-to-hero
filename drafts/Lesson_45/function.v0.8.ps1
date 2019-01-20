function Get-ComputerSystemInfo  {
    
    param(
        [string[]]$ComputerName
    )

    BEGIN{}
    PROCESS{
        
        if($_ -ne $null){
            $ComputerName = $_
        }

        foreach ($computer in $ComputerName){
            Get-WmiObject -Class win32_computersystem -ComputerName $computer | 
                Select-Object -Property Name, Manufacturer, Model
        }

    }
    END{}
}


# Get-Content C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_45\computers.txt | Get-ComputerSystemInfo 

# Get-ComputerSystemInfo -ComputerName (Get-Content C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_45\computers.txt)