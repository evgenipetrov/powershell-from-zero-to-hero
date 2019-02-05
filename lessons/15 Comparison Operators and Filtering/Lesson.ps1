## Basic comparison operators
# < > = <= >= <> !=

5 -eq 5

5 -ne 6

# comparison operators, msdn

"hello" -eq "hello"

## Wildcard string comparisons

"hello" -like "*l*"
# test case sensitivity

# get services and check if a certain service is running

## Filtering items out of pipeline

# why filter?
# where-object / block script
# aliases
# $_ vs $PSItem

# can we filter multiple times? objects | where | where | where
Get-Service | Where-Object -Property X -EQ -Value Y
# filter left/format right
# internal vs external filters

## Basic boolean operators
# -and -or
# $true/$false, do we need to compare it?

# -not operator