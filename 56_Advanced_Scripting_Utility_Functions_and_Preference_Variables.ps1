<# 56. ADVANCED SCRIPTING: PRIVATE UTILITY FUNCTIONS AND PREFERENCE VARIABLES #>

## 0. Preparation: Adding custom module path
Remove-Module MyTools

$customModulePath = "C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_56\"
if ($env:PSModulePath -notlike "*$customModulePath*" )
{
	$env:PSModulePath = $env:PSModulePath + ";$customModulePath"
}

$env:PSModulePath

## 1. Making module functions "private"

# see the module. Why testing the connection is not so good logic?

# exposing functions with 
help Export-ModuleMember #functions

## 2. Creating private and public module variables. Scopes.

# exporting variables is done with the same commandlet that can export functions from a module.
help Export-ModuleMember #variables

# wrong
Export-ModuleMember -Variable $VariableName

# correct
Export-ModuleMember -Variable VariableName
