function Get-DiskSpaceInfo
{
  [CmdletBinding()]
  param
  (
    [String[]]$ComputerName,
    [Switch]$LocalOnly = $true
  )
  
  begin{}
  
  process{
    foreach ($computer in $ComputerName)
    {
      $params = @{
        'ComputerName' = $computer
        'Class'      = 'Win32_LogicalDisk'
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
          '{0:N2}' -f ($_.Size)
        }
      }, 
      @{
        n = 'FreeSpace'
        e = {
          '{0:N2}' -f ($_.FreeSpace)
        }
      }, 
      @{
        n = 'FreePercent'
        e = {
          '{0:N2}' -f ($_.FreeSpace / $_.Size)
        }
      }
    }
  }
  
  end {}
}

function Get-DiskSpaceInfo2
{
  <#
      .SYNOPSIS
      Retrieves basic disk capacity information from one or more computers.

      .DESCRIPTION
      See the synopsis. This command uses WMI to retrieve information about free disk space from remote computers.
      It does not allow you to specify alternate credentials.

      .PARAMETER ComputerName
      One or more computer names, or IP addresses, to query.
      For example:
      Get-DiskSpaceInfo -ComputerName ONE,TWO,THREE

      .PARAMETER LocalOnly
      Specify this to include only local disd in the output.
      This is on by default
      Get-DiskSpaceInfo -ComputerName CLIENT -LocalOnly:$false

      .EXAMPLE
      Get-DiskSpaceInfo -ComputerName ONE,TWO
      This example retrieves disk space info from computers ONE and TWO.

      .EXAMPLE
      Get-DiskSpaceInfo -ComputerName 192.168.10.2
      This example retrieves disk space details from a computer that is specified by this IP address.

      .LINK
      http://www.google.com

      .LINK
      Get-Content
  #>
  [CmdletBinding()]
  param
  (
    [String[]]$ComputerName,
    [Switch]$LocalOnly = $true
  )
  
  begin{}
  
  process{
    foreach ($computer in $ComputerName)
    {
      $params = @{
        'ComputerName' = $computer
        'Class'      = 'Win32_LogicalDisk'
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
          '{0:N2}' -f ($_.Size)
        }
      }, 
      @{
        n = 'FreeSpace'
        e = {
          '{0:N2}' -f ($_.FreeSpace)
        }
      }, 
      @{
        n = 'FreePercent'
        e = {
          '{0:N2}' -f ($_.FreeSpace / $_.Size)
        }
      }
    }
  }
  
  end {}
}

function Get-DiskSpaceInfo3
{
  <#
      .EXTERNALHELP
  #>
  [CmdletBinding()]
  param
  (
    [String[]]$ComputerName,
    [Switch]$LocalOnly = $true
  )
  
  begin{}
  
  process{
    foreach ($computer in $ComputerName)
    {
      $params = @{
        'ComputerName' = $computer
        'Class'      = 'Win32_LogicalDisk'
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
          '{0:N2}' -f ($_.Size)
        }
      }, 
      @{
        n = 'FreeSpace'
        e = {
          '{0:N2}' -f ($_.FreeSpace)
        }
      }, 
      @{
        n = 'FreePercent'
        e = {
          '{0:N2}' -f ($_.FreeSpace / $_.Size)
        }
      }
    }
  }
  
  end {}
}