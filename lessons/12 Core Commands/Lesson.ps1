## Sorting

Get-Process # excel? unix approach?

# PowerShell object oriented approach
gps | gm

Get-Process | Sort-Object -Property ws
Get-Process | sort ws -Descending

## Selecting
Get-Process | sort ws -Descending | Select-Object -First 5
Get-Process | sort ws | Select-Object -Last 5
Get-Process | sort name,ws # Adcending/Descending for both
Get-Process | Select-Object -Property Name
Get-Process | Select-Object -Property Name, WS
Get-Process | Select-Object -Property Name, WS|gm # note typename
Get-Process | Select-Object -Property Name| gm
Get-Process | gm
Get-Process | Select-Object -Property Name| sort cpu # think pipeline contents/objects/members
Get-Process | Select-Object -Property nmae, vm, cpu

Get-Process | Select-Object -Property name,id,ws,pm,cpu
Get-Process | Select-Object -Property name,@{name='VM(MB)';expression={ $_.VM / 1MB }},@{label='PM(MB)';expression={$_.PM / 1MB }},ws,pm,cpu
Get-Process | Select-Object -Property name,@{name='VM(MB)';expression={ $_.VM / 1MB }},@{label='PM(MB)';expression={$_.PM / 1MB }},ws,pm,cpu | Format-Table -AutoSize
Get-Process | Select-Object -Property name,@{name='VM(MB)';expression={ $_.VM / 1MB }},@{label='PM(MB)';expression={$_.PM / 1MB -as [int]}},ws,pm,cpu 
Get-Process | Select-Object -Property name,@{n='VM(MB)';e={ $_.VM / 1MB }},@{l='PM(MB)';e={$_.PM / 1MB -as [int]}},ws,pm,cpu 
Get-Process | Select-Object -Property name,@{n='VM(MB)';e={ $_.VM / 1MB }} @{l='PM(MB)';e={$_.PM / 1MB -as [int]}},ws,pm,cpu # why the error?

# PS v3 
Get-Process | Select-Object -Property name,@{n='VM(MB)';e={ $PSItem.VM / 1MB }}

help Select-Object -Examples

## Measuring 
Get-Process | Measure-Object
Get-Process | Measure-Object -Property WorkingSet
Get-Process | Measure-Object -Property WorkingSet -Maximum -Minimum -Average -Sum
Get-Process | Measure-Object -Property WorkingSet -Max -Min -Avg -Sum # what is the problem here? abbreviations vs truncations. Tab completion is your friend.

## Grouping

Get-Service | Group-Object -Property Status

Get-Command -Noun Object
Get-Process | Sort-Object -Property ws | Select-Object -Last 5 | gm
Get-Process | Sort-Object -Property ws | Select-Object -Last 5 | Measure-Object -Property WorkingSet -Maximum -Minimum -Average -Sum | gm
