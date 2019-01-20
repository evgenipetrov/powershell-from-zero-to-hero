#requires -Version 3.0
<# 52. ADVANCED FUNCTIONS: PARAMETER ATTRIBUTES #>

## 0. Preparation: Adding custom module path
Remove-Module MyTools

$customModulePath = "{0}\Scripts\Lesson_52\" -f $PSScriptRoot
if ($env:PSModulePath -notlike "*$customModulePath*" )
{
  $env:PSModulePath = $env:PSModulePath + ";$customModulePath"
}

$env:PSModulePath

## 1. Mandatory parameters

param
(
  [Parameter(Mandatory=$true)]
  [string[]]$Parameter
)

## 2. Help messages
param
(
  [Parameter(HelpMessage='Computer name to query')]
  [string[]]$Parameter
)

## 3. Positional parameters
param
(
  [Parameter(Position=1)]
  [string[]]$Parameter
)

## 4. Parameter Validation
param
(
  [ValdateSet('OptionA','OptionB')]
  [ValidatePattern('\w+\.lab\.pri')]
  [ValidateLength(1,100)]
  [ValidateCount(1,5)]
  [string[]]$Parameter
)

## 5. Parameter aliases
param
(
  [Alias('hostname')]
  [string[]]$Parameter
)