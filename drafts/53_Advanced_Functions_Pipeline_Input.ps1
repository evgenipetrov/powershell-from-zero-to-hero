<# 53. ADVANCED FUNCTIONS: ACCEPTING PIPELINE INPUT #>

## 0. Preparation: Adding custom module path
Remove-Module MyTools

$customModulePath = "C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_53\"
if ($env:PSModulePath -notlike "*$customModulePath*" )
{
  $env:PSModulePath = $env:PSModulePath + ";$customModulePath"
}

$env:PSModulePath

## 1. By Value

# syntax
  param
  (
    [Parameter( ValueFromPipeline=$true)]
    [String[]]$Property
  )

# test it using parameter
Get-DiskSpaceInfo -ComputerName client.lab.pri,dc.lab.pri


# test it using pipeline ByValue execution plan
'client.lab.pri','dc.lab.pri' | Get-DiskSpaceInfo

# test it by using file contents with get-content command
$path = 'C:\Projects\powershell-from-zero-to-hero\Scripts\lesson_53\computers.txt'
Get-Content -Path $path | Get-DiskSpaceInfo


## 2. By property name

# syntax
  param
  (
    [Parameter( ValueFromPipelineByPropertyName=$true)]
    [String[]]$Property
  )

# test it by using file contents with get-content command
$path = 'C:\Projects\powershell-from-zero-to-hero\Scripts\lesson_53\computers.csv'
Import-Csv -Path $path | Get-DiskSpaceInfo

# an easy fix
Import-Csv -Path $path | Select-Object @{n='ComputerName';e={$_.Name}}, @{n='DriveType';e={$_.Type}} | Get-DiskSpaceInfo

# will this work?
Import-Csv -Path $path | Select-Object @{n='hostname';e={$_.Name}}, @{n='DriveType';e={$_.Type}} | Get-DiskSpaceInfo

