function Get-DiskLowCapacity {
    #[CmdletBinding()]

    param(
        [string[]]$ComputerName
    )

    PROCESS {
        foreach ($computer in $ComputerName) {
            Write-Verbose "Processing computer : $computer ..."
            $disk = Get-WmiObject   -Class Win32_LogicalDisk `
                                    -Filter "drivetype='3'" `
                                    -ComputerName $computer
            
            if($disk.freespace / $disk.size -lt .2) {
                $disk | Select-Object DeviceId, FreeSpace, Size
            }
        }
    }
}