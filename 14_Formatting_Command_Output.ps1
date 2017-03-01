<# 14. FORMATTING COMMAND OUTPUT #>

## 1. Formatting wide 

# intro
Get-Process | Format-Wide

# select any property
Get-Process | Format-Wide -Property Id

# cannot format by more than one property
Get-Process | Format-Wide -Property Id, Name

## 2. Formatting lists

# intro. note that properties are different from format table default properties
Get-Process | Format-List

# we can select all properties
Get-Process | Format-List -Property *

# we can select any property and number of properties
Get-Process | Format-List -Property Id, Name

# a great way to verify input data
Get-Process | Format-List -Property *

## 3. Formatting tables

# intro. note different properties from default format list output
Get-Process | Format-Table

# autosize is a convenient way to order the column width
Get-Process | Format-Table -AutoSize

# with format table we can again select any number of properties
Get-Process | Format-Table -Property Id, Name -AutoSize

# we can select all proprerties
Get-Process | Format-Table -Property *

# what will the following command do?
$Host.UI.RawUI.ForegroundColor = 'Green' 
$Host.UI.RawUI.BackgroundColor = 'Black' 
while ($true -eq $true) 
{
  Get-Process | Format-Table -Property *
}

# we can group by any property. note how inconvenient the output is. why? because of the way the command works 
Get-Service | Format-Table -GroupBy Status -Property name, status, displayname

# if we want a neat table we should sort them first
Get-Service |
Sort-Object -Property status |
Format-Table -GroupBy Status -Property name, status, displayname

# renaming columns is possible.
Get-Process | Format-Table -Property Name, Id, @{
  n = 'VM(MB)'
  e = {
    $_.VM/1MB
  }
}, @{
  n = 'PM(MB)'
  e = {
    $_.PM/1MB
  }
} -AutoSize

# format table is designed with display in mind. hotice how, if uncommented, the autosize disregards the width property
Get-Process | Format-Table -Property Name, Id, @{
  n            = 'VM(MB)'
  e            = {
    $_.VM/1MB
  }
  formatstring = 'N2'
  align        = 'right'
  width        = 55
}, @{
  n = 'PM(MB)'
  e = {
    $_.PM/1MB
  }
} # -AutoSize

# always have in mind what is in the pipeline
Get-Process |
Format-Table -Property Name, Id, @{
  n            = 'VM(MB)'
  e            = {
    $_.VM/1MB
  }
  formatstring = 'N2'
  align        = 'right'
  width        = 55
}, @{
  n = 'PM(MB)'
  e = {
    $_.PM/1MB
  }
} |
ConvertTo-Html |
Out-File -FilePath c:\temp\processes.html

# format table produces different objects. format commads produce objects designed for visual display. therefore formatting destroys data and must be done in the very end!
Get-Process |
Format-Table |
Get-Member

# filter to the left, format to the right
Get-Process |
Where-Object -FilterScript {
  $_.Name -eq 'svchost'
} |
Format-Table

