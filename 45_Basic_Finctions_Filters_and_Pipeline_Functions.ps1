<# 45. BASIC FUNCTIONS FILTERS AND PIPELINE FUNCTIONS #>

## 1. Basic Functions

# let us pick a command. Test it!
Get-WmiObject -Class win32_computersystem -ComputerName dc | Select-Object Name, Manufacturer, Model

# Immediately save the command to a file - 
gc -Path C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_45\function.ps1

# fix the formatting to maximize the readability

## 2. Filters

## 3. Pipeline Putput

