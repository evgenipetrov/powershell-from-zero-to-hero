Get-WmiObject -Class win32_logicaldisk -Filter "DriveType=3" -ComputerName dc.lab.pri | 
    Select-Object -Property @{n='ComputerName';e={$_.__SERVER}},
                            @{n='Drive';e={$_.DeviceId}},
                            @{n='FreeSpace(GB)';e={$_.FreeSpace / 1GB -as [int]}},
                            @{n='Size';e={$_.Size / 1GB -as [int]}}