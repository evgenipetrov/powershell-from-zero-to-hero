function Get-LatestSecurityLog {
    param(
        [string]$ComputerName
    )
    Get-EventLog -LogName Security -Newest 50 -ComputerName $ComputerName
}

Get-LatestSecurityLog -ComputerName dc.lab.pri

