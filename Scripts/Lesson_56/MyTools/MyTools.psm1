$ExampleDriveTypePreference = 'Local'

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
		[Parameter(ParameterSetName = 'List')]
		[switch]$ListDrivesOnly
	)
	
	
	PROCESS
	{
		foreach ($computer in $ComputerName)
		{
			$params = @{
				'ComputerName' = $computer
				'Class' = 'Win32_LogicalDisk'
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
					n = 'Drive'
					e = { $_.DeviceID }
				},
				@{
					n = 'Size'
					e = { '{0:N2}' -f ($_.Size) }
				},
				@{
					n = 'FreeSpace'
					e = { '{0:N2}' -f ($_.FreeSpace) }
				},
				@{
					n = 'FreePercent'
					e = { '{0:N2}' -f ($_.FreeSpace / $_.Size * 100) }
				}
			}
			else
			{
				$props = @{
					n = 'Drive'
					e = { $_.DeviceID }
				},
				@{
					n = 'Size'
					e = { '{0:N2}' -f ($_.Size) }
				}
			}
			
			Get-WmiObject @params |
			Select-Object $props
		}
	}
}

function Set-ComputerState
{
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true,
				   ValueFromPipeline = $true,
				   ValueFromPipelineByPropertyName = $true)]
		[string[]]$ComputerName,
		[switch]$Force,
		[Parameter(ParameterSetName = 'Logoff')]
		[switch]$Logoff,
		[Parameter(ParameterSetName = 'Restart')]
		[switch]$Restart,
		[Parameter(ParameterSetName = 'Shutdown')]
		[switch]$Shutdown,
		[Parameter(ParameterSetName = 'Poweroff')]
		[switch]$Poweroff
	)
	
	PROCESS
	{
		foreach ($computer in $ComputerName)
		{
			
			# why this is not good logic? How can we improve it scriptwise ?
			if (Test-Connection -ComputerName $computer -Quiet)
			{
				$works = $true
				try
				{
					Get-WmiObject -Class Win32_BIOS -ErrorAction Stop -ComputerName $computer
				}
				catch
				{
					$works = $false
				}
			}
			
			if ($works)
			{
				$os = Get-WmiObject -Class Win32_OperatingSystem -ComputerName $computer
				if ($Logoff) { $arg = 0 }
				if ($Restart) { $arg = 2 }
				if ($Shutdown) { $arg = 1 }
				if ($Poweroff) { $arg = 8 }
				if ($Force) { $arg += 4 }
			}
			$os.Win32Shutdown($arg)
		}
		
	}
}

function check($computer)
{
	$works = $true
	if (Test-Connection $computer -Quiet)
	{
		try
		{
			gwmi win32_bios -ComputerName $computer -ea stop
		}
		catch
		{
			$works = $false
		}
	}
	else
	{
		$works = $false
	}
	
	return $works
}

function Set-ComputerState2
{
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true,
				   ValueFromPipeline = $true,
				   ValueFromPipelineByPropertyName = $true)]
		[string[]]$ComputerName,
		[switch]$Force,
		[Parameter(ParameterSetName = 'Logoff')]
		[switch]$Logoff,
		[Parameter(ParameterSetName = 'Restart')]
		[switch]$Restart,
		[Parameter(ParameterSetName = 'Shutdown')]
		[switch]$Shutdown,
		[Parameter(ParameterSetName = 'Poweroff')]
		[switch]$Poweroff
	)
	
	PROCESS
	{
		foreach ($computer in $ComputerName)
		{
			
			# what problem does this approach solve?
			if (check $computer)
			{
				$os = Get-WmiObject -Class Win32_OperatingSystem -ComputerName $computer
				if ($Logoff) { $arg = 0 }
				if ($Restart) { $arg = 2 }
				if ($Shutdown) { $arg = 1 }
				if ($Poweroff) { $arg = 8 }
				if ($Force) { $arg += 4 }
			}
			$os.Win32Shutdown($arg)
		}
		
	}
}

function check2($computer)
{
	$works = $true
	if (Test-Connection $computer -Quiet)
	{
		try
		{
			gwmi win32_bios -ComputerName $computer -ea stop | Out-Null
		}
		catch
		{
			$works = $false
		}
	}
	else
	{
		$works = $false
	}
	
	return $works
}

Export-ModuleMember -Function Get-DiskSpaceInfo, Set-ComputerState
