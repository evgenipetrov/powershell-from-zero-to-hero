# default formatting

## Format Wide
Get-Process | Format-Wide # 2 column list by default, only one property
Get-Process | Format-Wide -Property Id -Column 4 # 4 column list, only one property

## Format List
Get-Process
Get-Process | Format-List # 4 properties, vs 8 properties for the default table. Why?
Get-Process | Format-List -Property Id, Name, CPU, WS, VM
Get-Process | Format-List -Property * # properties + values
Get-Process | fl *

## Format Table
Get-Process
Get-Process | Format-Table
Get-Process | Format-Table -Property Name, Id, CPU, WS, VM # notice that it expands to full buffer size
Get-Process | Format-Table -Property Name, Id, CPU, WS, VM -AutoSize
Get-Process | ft * -AutoSize
Get-Process | ft *

Get-Service | Format-Table -GroupBy status
Get-Service | Sort-Object -Property status | Format-Table -GroupBy status

Get-Process | Format-Table -Property Name, Id, @{n='VM(MB)'; e={$_.VM / 1MB}} #, @{}
Get-Process | Format-Table -Property Name, Id, @{n='VM(MB)'; e={$_.VM / 1MB};'formatstring'='N2'}

help Format-Table -Examples

## Common formatting gotchas

Get-Process | Format-Table | ConvertTo-Html | Out-File -FilePath c:\processes.html # think what is in the pipeline

# N.B. format- command must be the last thing on the line! Format right!
# Select-Object vs Format-Table/Format-List

Out-Host
Out-Printer
Out-File

Out-GridView
Get-Process | Format-Table | Out-GridView