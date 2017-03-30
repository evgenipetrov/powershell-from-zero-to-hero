<# 54. ADVANCED FUNCTIONS: PARAMETER SETS #>

## 0. Preparation: Adding custom module path
Remove-Module MyTools

$customModulePath = "C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_54\"
if ($env:PSModulePath -notlike "*$customModulePath*" )
{
  $env:PSModulePath = $env:PSModulePath + ";$customModulePath"
}

$env:PSModulePath

## 1. Working with parameter sets

# see the help for Get-EventLog command and notice the parameter sets
help Get-EventLog

# the point of parameter sets is to have one command do 2 different things, with different purpose
# notice how picking an unique parameter from a set locks us in the same parameter set
Get-EventLog -ComputerName dc.lab.pri -List ...

# see the help for parameter sets
help about_functions_advanced_parameters

# syntax

param(
    [parameter(Mandatory=$true,
    ParameterSetName="Computer")]
    [String[]]
    $ComputerName
)

# see the example in MyTools module - Get-DiskSpaceInfo
help Get-DiskSpaceInfo

# try using parameters from different sets
Get-DiskSpaceInfo -ListDrivesOnly -ComputerName dc.lab.pri

