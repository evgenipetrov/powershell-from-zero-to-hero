#requires -Version 2.0
$ExampleDriveTypePreference = 'Local'
$ExampleErrorLogFile = 'c:\errors.txt'

function Get-DiskSpaceInfo
{
  [CmdletBinding()]
  param
  (
    [Parameter(Mandatory = $true,
        HelpMessage = 'Computer name to query',
        Position = 1,
        ValueFromPipeline = $true,
    ValueFromPipelineByPropertyName = $true)]
    [Alias('Hostname')]
    [String[]]$ComputerName,
    [Parameter()]
    [Switch]$LocalOnly = $true,
    [Parameter(Position = 2,
    ParameterSetName = 'Info')]
    [ValidateSet('Floppy', 'Local', 'Optical')]
    [string]$DriveType = $ExampleDriveTypePreference,
		
    [string]$ErrorLogFile = $ExampleErrorLogFile
  )
	
	
  PROCESS
  {
    foreach ($computer in $ComputerName)
    {
      $params = @{
        'ComputerName' = $computer
        'Class'      = 'Win32_LogicalDisk'
      }
			
      switch ($DriveType)
      {
        'Local'
        {
          $params.Add('Filter', 'DriveType=3')
          break
        }
        'Floppy'
        {
          $params.Add('Filter', 'DriveType=2')
          break
        }
        'Optical'
        {
          $params.Add('Filter', 'DriveType=5')
          break
        }
      }
			
      if (-not $ListDrivesOnly)
      {
        $props = @{
          n = 'Drive'; e = { $_.DeviceID }
        }, 
        @{
          n = 'Size'; e = {'{0:N2}' -f ($_.Size)}
        }, 
        @{
          n = 'FreeSpace'; e = {'{0:N2}' -f ($_.FreeSpace)}
        }, 
        @{
          n = 'FreePercent'; e = {'{0:N2}' -f ($_.FreeSpace / $_.Size * 100)}
        }
      }
      else
      {
        $props = @{
          n = 'Drive'
          e = {$_.DeviceID}
        }, 
        @{
          n = 'Size'
          e = {'{0:N2}' -f ($_.Size)}
        }
      }
	    		


      try {
          Get-WmiObject @params -ErrorAction Stop| Select-Object $props
          Write-Host 'tralal'
      }
      catch {
        $computer | Out-File -FilePath $ExampleErrorLogFile
      }


    }
  }
}

Export-ModuleMember -Function Get-DiskSpaceInfo -Variable ExampleDriveTypePreference, ExampleErrorLogFile
