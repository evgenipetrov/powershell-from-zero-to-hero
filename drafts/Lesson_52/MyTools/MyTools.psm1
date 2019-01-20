function Get-DiskSpaceInfo
{
  [CmdletBinding()]
  param
  (
    [Parameter(Mandatory = $true,
                HelpMessage = 'Computer name to query')]
    [Alias('Hostname')]
    [Alias('Name')]
    [ValidatePattern('\w+\.lab\.pri')]
    [String[]]$ComputerName,
    
    [Parameter()]
    [Switch]$LocalOnly = $true,
    
    [Parameter(Position = 2)]
    [ValidateSet('Floppy','Local','Optical')]
    [string]$DriveType = 'Local'
  )
  
  begin{}
  
  process{
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
      
      
      if ($LocalOnly)
      {
        $params.Add('Filter','DriveType=3')
      }
      
      Get-WmiObject @params |
      Select-Object @{
        n = 'Drive'
        e = {
          $_.DeviceID
        }
      }, 
      @{
        n = 'Size'
        e = {
          "{0:N2}" -f ($_.Size/1GB)
        }
      }, 
      @{
        n = 'FreeSpace'
        e = {
          "{0:N2}" -f ($_.FreeSpace/1GB)
        }
      }, 
      @{
        n = 'FreePercent'
        e = {
          "{0:N2}" -f ($_.FreeSpace / $_.Size * 100)
        }
      }
    }
  }
  
  end {}
}


