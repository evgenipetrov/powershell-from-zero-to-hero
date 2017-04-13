<# 62. ADVANCED SCRIPTING:EXTENSIBLE TYPE SYSTEM #>

## 0. Preparation: Adding custom module path

if (Get-Module -Name MyTools) 
{
  Remove-Module MyTools
}

$customModulePath = "C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_62\"
if ($env:PSModulePath -notlike "*$customModulePath*" )
{
	$env:PSModulePath = $env:PSModulePath + ";$customModulePath"
}

$env:PSModulePath

## 1. The extensioble type system

# Notice the AliasProperties
Get-Process | Get-Member

# AliasProperty vs ScriptProperty vs PropertySet
Get-Process | Select-Object PSResources

## 2. How ETS works

# Notice the System.Diagnostics.Process
notepad C:\Windows\System32\WindowsPowerShell\v1.0\types.ps1xml

## 3. Extending types on your own

# Create a new ps1xml file and try to set your extensions. Assume the xml is case sensitive.
# Do not forget to reload the module and the TypeData
Update-TypeData

# Add the TypeData to the module manifest. Make sure the types file lives in the module folder.
# Try to add ScriptProperty and ScriptMethod
