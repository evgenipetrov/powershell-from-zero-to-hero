## Basic comparison operators
# < > = <= >= <> !=

5 -eq 5

5 -ne 6

# Comparison operators
# -gt -lt -ge -le -like

"hello" -eq "hello"
"hello" -eq "Hello" # by default string comparison is case insensitive

## Wildcard string comparisons

"hello" -like "*l*"
"hello" -contains "l" # for arrays only!

# Case sensitivity

## Filtering items out of pipeline

# why filter?
Get-Service | Where-Object -FilterScript {$_.Name -eq "BITS"} | Select-Object -ExpandProperty status
Get-Service | Where-Object -FilterScript {$_.Name -eq "BITS"} | Select-Object -Property status, Name | fl
Get-Service | Select-Object -Property status, Name | Where-Object -FilterScript {$_.Name -eq "BITS"} 

# aliases: ? , where
# $_ vs $PSItem
Get-Service | Select-Object -Property status, Name | Where-Object -FilterScript {$_.Name -eq "BITS"} 
Get-Service | Select-Object -Property status, Name | Where-Object -FilterScript {$PSItem.Name -eq "BITS"} 

# Multi filtering | where | where | where
Get-Service | ? {$_.Name -like "a*"} | where {$PSItem.Status -ne "running"} # less efficient
Get-Service | ? {$_.Name -like "a*" -and $_.Status -eq "stopped"} # more efficient and faster

Get-Service | Where-Object -Property X -EQ -Value Y
# Rule: Filter to the left, format to the right
# Internal vs. external filters
Get-Process -Name svchost # more efficient and quicker
Get-Process | where 'name' -eq 'svchost' # less efficient and quicker

## Basic boolean operators
# -and -or
# $true and $false; do we need to compare them?

# Inversions: -not operator