<# 59. ADVANCED SCRIPTING: THE OLD WAY TRAP #>

## 0. Preparation: Adding custom module path

if (Get-Module -Name MyTools) 
{
  Remove-Module MyTools
}

$customModulePath = "C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_59\"
if ($env:PSModulePath -notlike "*$customModulePath*" )
{
	$env:PSModulePath = $env:PSModulePath + ";$customModulePath"
}

$env:PSModulePath

## 1. Execution flow

# example and flow. Is there a try catch block? Is there a trap block before the error?

trap{
    $error[0]

    continue/break
}


## 2. Trap vs Try/Catch