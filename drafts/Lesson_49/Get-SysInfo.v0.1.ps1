param(
    [string]$ComputerName
)

Get-WmiObject -Class win32_operatingsystem -ComputerName $ComputerName
Get-WmiObject -Class win32_bios -ComputerName $ComputerName