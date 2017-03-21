param(
    [string]$ComputerName = (Read-Host "Specify a computer name to query"),
    [int]$DriveType = 3
)
Get-WmiObject -Class win32_logicaldisk -Filter "DriveType=$DriveType" -ComputerName $ComputerName | 
    Select-Object -Property @{n='ComputerName';e={$_.__SERVER}},
                            @{n='Drive';e={$_.DeviceId}},
                            @{n='FreeSpace(GB)';e={$_.FreeSpace / 1GB -as [int]}},
                            @{n='Size';e={$_.Size / 1GB -as [int]}}