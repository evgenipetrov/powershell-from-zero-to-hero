<# 51. ADVANCED SCRIPTING: CUSTOM FORMATTING VIEWS #>

## 0. Preparation: Adding custom module path

if (Get-Module -Name MyTools) 
{
  Remove-Module MyTools
}

$customModulePath = "C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_61\"
if ($env:PSModulePath -notlike "*$customModulePath*" )
{
	$env:PSModulePath = $env:PSModulePath + ";$customModulePath"
}

$env:PSModulePath

## 1. How formatting works

# An example for nice formatting
Get-Process

# Now the same object, but raw data
Get-Process | Select-Object -First 1 | Format-List -Property *

# Default formatting is defined here
code C:\Windows\System32\WindowsPowerShell\v1.0\DotNetTypes.format.ps1xml

# Notice the view that has been designed specifically for the TypeName: System.Diagnostics.Process
# Notice the TableControl element and the definitions of the columns. Notice the labels, alignments and widths.
# Notice the TableColumnHeader without label. Notice the TableColumnHeader without any definitions and self closes.
# Notice the TableRowEntries. These are our expressions.

## 2. Adding a custom type name

## 3. Creating custom views

# Create an empty file and copy the opening tags from the original 
# Get the view from the original. Note they are case sensitive in PS v2

Get-SystemInfo -ComputerName localhost

## 4. Loading views manually

Update-FormatData -AppendPath C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_61\MyTools\myview.format.ps1xml

## 5. Loading views in a module manifest

New-ModuleManifest  -Path C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_61\MyTools\MyTools.psd1 `
                    -RootModule C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_61\MyTools\MyTools.psm1 `
                    -FormatsToProcess myview.format.ps1xml
