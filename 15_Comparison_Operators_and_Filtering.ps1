<# 15. COMPARISON OPERATORS AND FILTERING #>

## 1. Basic comparison operators

# equal
5 -eq 5

# not equal
10 -ne 10

# greater than
6 -gt 7

# less than
8 -lt 10

# greater or equal
5 -ge 5

# less or equal
5 -le 5

# string comparison, case insensitive
'hello' -eq 'HELLO'

# string comparison, case sensitive
'hello' -ceq 'HELLO'

## 2. Wildcard string operators

# wildcard comparison
'hello' -like '*ell*'

# case sensitive wildcard comparison
'hello' -clike '*Ell*'

# real life example
(Get-Service -Name SPTimerV4).Status -eq 'Running'

# another example with filterscript
Get-Service | Where-Object -FilterScript {$_.Name -like 's*'}

# shorter, with alias
Get-Service | Where-Object {$_.Name -like 's*'}

# even shorter
Get-Service | Where {$_.Name -like 's*'}

# can we get shorter than that?
Get-Service | ? {$_.Name -like 's*'}

# yes we can!
gsv | ? {$_.Name -like 's*'}

## 3. Basic boolean operators

# comparing boolean values
Get-Process | Where-Object { $_.Responding -eq $true } | Format-Wide -Property name

# we do not need to compare them actually
Get-Process | Where-Object { $_.Responding } | Format-Wide -Property name

# let us reverse the logic. no output is good
Get-Process | Where-Object { -not $_.Responding } | Format-Wide -Property name

# can we get shorter? yes - in PS 3.0+
Get-Service | Where-Object 'Status' -eq 'Running' 

## 4. Filtering items out of pipeline

# filtering several times is slow
Get-Service | Where-Object {$_.Name -like 's*'} | Where-Object {$_.Status -ne 'running'}

# compared to filtering at once. can we make it even better?
Get-Service | Where-Object {$_.Name -like 's*' -and $_.Status -ne 'running'}

# yes we can filter even more to the left
Get-Service -Name s* | Where-Object {$_.Status -ne 'running' }

# if you are filtering natively with command bear the underlying technology filtering syntax
Get-ADUser -Filter 'Name -like "*SERVICE"'

# or not ...
Get-ADUser -Filter * | Where-Object { $_.Name -like '*service' }

# filtering in PS 40+
(Get-Service).Where({ $PSItem.status -eq 'running' })





