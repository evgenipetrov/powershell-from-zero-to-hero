<# 17. SETTING DEFAULT VALUES FOR COMMAND PARAMETERS #>

# PS 3.0+

## 1. Defining defaults

# we start with empty defaults
$PSDefaultParameterValues

# let us assign some defaults
$PSDefaultParameterValues = @{"Get-EventLog:Newest"=10}
Get-EventLog -LogName System

# we can override the default option easily
Get-EventLog -LogName System -Newest 2

## 2. Adding defaults

# add a value by completely redefining the hashtable
$PSDefaultParameterValues = @{
    "Get-EventLog:Newest"=10;
    "Get-EventLog:LogName"="System"}
Get-EventLog

# or simply add a value 
$PSDefaultParameterValues.Add("Get-EventLog:ComputerName","localhost")

# add a wildcard default for all commands having a ComputerName parameter
$PSDefaultParameterValues.Add("*:ComputerName","DC")

# add a wildcard default for all "Get" commands having a ComputerName parameter
$PSDefaultParameterValues.Add("Get-*:ComputerName","DC")

## 3. Removing defaults

# remove a value by providing the complete key
$PSDefaultParameterValues.Remove("Get-EventLog:Newest")

## 4. Enabling and disabling defaults

# disable it
$PSDefaultParameterValues['Disabled'] = $true

# they are still defined
$PSDefaultParameterValues

# enable it by removing the key
$PSDefaultParameterValues.Remove("Disabled")

# you can also enable it by simply setting the key to $false
$PSDefaultParameterValues['Disabled'] = $false
Get-EventLog

