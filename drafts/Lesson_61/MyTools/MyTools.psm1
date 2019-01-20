function Get-SystemInfo {
  [CmdletBinding()]
  param(
    [string[]]$ComputerName
  )
  PROCESS {
    foreach ($computer in $ComputerName) {
        
      $os = Get-WmiObject -Class Win32_OperatingSystem -ComputerName $computer
      $comp = Get-WmiObject -Class Win32_ComputerSystem -ComputerName $computer
      $proc = Get-WmiObject -Class Win32_Processor -ComputerName $computer
      $bios = Get-WmiObject -Class Win32_BIOS -ComputerName $computer

      if (($os.osarchitecture -replace '-bit', '') -ne ([string]$proc.addresswidth)) {
        $optimal = $false
      } else {
        $optimal = $true
      }
      $props = @{
        'ComputerName'      = $computer
        'OSVersion'         = $os.version
        'Mfgr'              = $comp.manufacturer
        'Model'             = $comp.model
        'OSArchitecture'    = $os.osarchitecture
        'ProcArchitecture'  = $proc.addresswidth
        'BIOSSerical'       = $bios.serialnumber
        'OptimalArchitecture' = $optimal
      }
      $obj = New-Object -TypeName PSObject -Property $props
      $obj.psobject.typenames.insert(0,'Lab.MyTools.SystemInfo')
      Write-Output -InputObject $obj
    }
  }
}

Export-ModuleMember -Function Get-SystemInfo
