#v3+
## Defining defaults

Get-EventLog -LogName Security -Newest 10

$PSDefaultParameterValues # restricted to current shell

## Adding defaults

$PSDefaultParameterValues = @{'Get-EventLog:Newest' = 5}

$PSDefaultParameterValues = @{
    'Get-EventLog:Newest' = 5
    'Get-EventLog:LogName' = 'Security'
}

$PSDefaultParameterValues.Add('Get-EventLog:ComputerName', 'DC')

Get-EventLog -LogName Application

## Removing defaults

$PSDefaultParameterValues.Remove('Get-EventLog:ComputerName')
$PSDefaultParameterValues.Remove('Get-EventLog:LogName')

## Enabling and disabling defaults

$PSDefaultParameterValues['Disabled'] = $true
Get-EventLog

$PSDefaultParameterValues.Remove('disabled')

## Hacks

$PSDefaultParameterValues = @{}
Get-Service

$PSDefaultParameterValues.Add('*:ComputerName','DC')
Get-Service
Get-WmiObject -Class win32_operatingsystem
Get-WmiObject -Class win32_operatingsystem -ComputerName localhost

$PSDefaultParameterValues.Remove('*:ComputerName')
$PSDefaultParameterValues.Add('Get-*:ComputerName')