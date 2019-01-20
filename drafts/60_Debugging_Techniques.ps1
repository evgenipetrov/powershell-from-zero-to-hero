<# 59. ADVANCED SCRIPTING: DEBUGGING TECHNIQUES #>

## 0. Preparation: Adding custom module path

if (Get-Module -Name MyTools) 
{
  Remove-Module MyTools
}

$customModulePath = "C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_60\"
if ($env:PSModulePath -notlike "*$customModulePath*" )
{
	$env:PSModulePath = $env:PSModulePath + ";$customModulePath"
}

$env:PSModulePath

## 1. The purpose of debugging

# Bugs vs syntax errors.

# Syntax errors are not a problem due to color higlighting and good indentation habits.

# example
Get-DiskLowCapacity -ComputerName dc,client

# start the console and get out of the script. try to find the problem

## 2. Writing debug info

help Write-Debug

help Write-Verbose

# cmdlet binding vs debug and verbose preferences

## 3. ISE Breakpoints

# F9



## 4. Console breakpoints

help Set-PSBreakpoint
