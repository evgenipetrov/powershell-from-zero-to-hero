#requires -Version 3.0
<# 51. ADVANCED FUNCTIONS: ADDING HELP #>

## 0. Preparation: Adding custom module path

$customModulePath = "$PSScriptRoot\Scripts\Lesson_51\"
if ($env:PSModulePath -notlike "*$customModulePath*" )
{
  $env:PSModulePath = $env:PSModulePath + ";$customModulePath"
}
$env:PSModulePath

## 1. Comment based help

# example function Get-DiskSpaceInfo into custom module
Get-Command Get-DiskSpaceInfo

# Check if the command has help
help -Name Get-DiskSpaceInfo

# PowerShell comment based help 
help -Name about_comment_based_help

# get help for the Get-DiskSpaceInfo2 command. It is all the same but with comment based help.
help -Name Get-DiskSpaceInfo2
help -Name Get-DiskSpaceInfo2 -Full
help -Name Get-DiskSpaceInfo2 -Online

## 2. External (XML) help

# build it with = https://pscmdlethelpeditor.codeplex.com/


