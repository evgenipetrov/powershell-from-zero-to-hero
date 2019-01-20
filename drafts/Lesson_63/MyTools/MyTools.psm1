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

function Get-DiskDetails {
  [CmdletBinding()]
  param
  (
    [String[]]
    [Parameter(Mandatory=$true,
                ValueFromPipeline=$true,
                ValueFromPipelineByPropertyName=$true)]
    $ComputerName
  )
  PROCESS {
    foreach ($computer in $ComputerName)
    {
      $disks = Get-WmiObject -Class win32_logicaldisk -Filter "drivetype=3" -ComputerName $computer
      foreach ($disk in $disks)
      {
        $properties = @{
          'ComputerName'=$computer;
          'Drive'=$disk.deviceid;
          'FreeSpace'="{0:N2}" -f ($disk.freespace / 1GB);
          'Size'="{0:N2}" -f ($disk.size / 1GB);
          'FreePercent'="{0:N2}" -f ($disk.freespace / $disk.size * 100);
        }
        $object = New-Object -TypeName PSObject -Property $properties
        Write-Output $object
        
      }
      
    }
    
  }
}

function Save-DiskDetailsToDatabase
{
  [CmdletBinding()]
  param
  (
    [object[]]
    [Parameter(Mandatory=$true,
                ValueFromPipeline=$true)]
    $InputObject
   )
   
   BEGIN {
    $connection = New-Object -TypeName System.Data.SqlClient.SqlConnection
    $connection.ConnectionString = "Server=sql.lab.pri;Database=PS_AdminData;Trusted_Connection=True;"
    $connection.Open() | Out-Null
  }
  
  PROCESS {
    $command = New-Object -TypeName System.Data.SqlClient.SqlCommand
    $command.Connection = $connection
    #$command.CommandType = [System.Data.CommandType.Text]
    #$sql = "SELECT COUNT(Id) AS num FROM DiskData WHERE ComputerName = '$($InputObject.ComputerName)' AND DriveLetter = '$($InputObject.Drive)'"

    $sql = "DELETE FROM DiskData WHERE ComputerName = '$($InputObject.ComputerName)' AND DriveLetter = '$($InputObject.Drive)'"
    $command.CommandText = $sql
    $command.ExecuteNonQuery() | Out-Null

    $sql = "INSERT INTO DiskData (ComputerName, DriveLetter, FreeSpace, Size, FreePercent) VALUES('$($InputObject.Computername)','$($InputObject.Drive)',$($InputObject.FreeSpace),$($InputObject.Size),$($InputObject.FreePercent))"
    $command.CommandText = $sql
    $command.ExecuteNonQuery() | Out-Null
  }

  END {
    $connection.Close()
  }
}

function Get-ComputerNamesForDiskDetailsFromDatabase {
    $connection = New-Object -TypeName System.Data.SqlClient.SqlConnection
    $connection.ConnectionString = "Server=sql.lab.pri;Database=PS_AdminData;Trusted_Connection=True;"
    $connection.Open() | Out-Null

    $command = New-Object -TypeName System.Data.SqlClient.SqlCommand
    $command.Connection = $connection

    $sql = "SELECT ComputerName FROM DiskData"
    $command.CommandText = $sql
    $reader = $command.ExecuteReader()

    while ($reader.read()){
        $computername = $reader.GetSqlString(0).Value
        Write-Output $computername
    }

    $connection.Close()
}


