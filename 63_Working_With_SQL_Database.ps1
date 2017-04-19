<# 62. ADVANCED SCRIPTING:WORKING WITH SQL DATABASES #>

## 0. Preparation: Adding custom module path

if (Get-Module -Name MyTools) 
{
  Remove-Module MyTools
}

$customModulePath = "C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_63\"
if ($env:PSModulePath -notlike "*$customModulePath*" )
{
	$env:PSModulePath = $env:PSModulePath + ";$customModulePath"
}

$env:PSModulePath

# using Management Studio: 

# a) create a database PS_AdminData
# b) create a table with columns that will reflect object properties to store in teh database
# helper: connectionstrings.com

## 1. Reading data from SQL

Get-ComputerNamesForDiskDetailsFromDatabase

## 2. Writing data to SQL

Get-DiskDetails | Save-DiskDetailsToDatabase

## 3. Updating data to SQL

Get-ComputerNamesForDiskDetailsFromDatabase | Get-DiskDetails | Save-DiskDetailsToDatabase