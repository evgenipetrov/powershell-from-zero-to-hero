<# 57. ADVANCED SCRIPTING: BASIC ERROR HANDLING #>

## 0. Preparation: Adding custom module path

if (Get-Module -Name MyTools) 
{
  Remove-Module MyTools
}

$customModulePath = "C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_57\"
if ($env:PSModulePath -notlike "*$customModulePath*" )
{
	$env:PSModulePath = $env:PSModulePath + ";$customModulePath"
}

$env:PSModulePath

## 1. How errors work in PowerShell

# what errors can we anticipate witht eh Get-DiskSpaceInfo command?

# Task: add error handling to Get-DiskSpaceInfo. Add logging with module variable. Add parameter to the command so that it can log errors to a specific file

# add check in the begin section so that we can spot already existing error file and start appending.

# $ErrorActionPreference variable. what does it do?. Terminating and non terminating exceptions

# "Inquire" preference.

# "Stop" preference.

# error action preference scope - command, script, environment

# Explain "try catch finally" construction

# -ErrorVariable

## 2. Basic error handling (do not do that)

# try not to shutdown error preferences for the entire environment

# with executing methods the only way to change the preference for error handling is to set a script/env variable. Methods do not have -ErrorAction key