<# 59. ADVANCED SCRIPTING: THE OLD WAY TRAP #>

## 0. Preparation: Adding custom module path

if (Get-Module -Name MyTools) 
{
  Remove-Module MyTools
}

$customModulePath = "C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_58\"
if ($env:PSModulePath -notlike "*$customModulePath*" )
{
	$env:PSModulePath = $env:PSModulePath + ";$customModulePath"
}

$env:PSModulePath

## 1. Quick review of the basics

# .NET exceptions

# PowerShell error record

Get-Content nonexistant.txt

$error

# properties

$error[0].TargetObject

$error[0].CategoryInfo

$error[0].InvocationInfo

$error[0] | gm

# clear the errors
# $error.Clear()

# maximum error count to store
$MaximumErrorCount

# potential problem: FIFO stack

## 2. ErrorActions

$ErrorActionPreference

## 3. ErrorVariables

# -ErrorVariable

Get-Content nonexisting.txt -ErrorVariable x
$x

# custom variable count method vs $null comparison

# $error vs $x error stacking and order

# $_

# error variable highjacking