## 1. Commands and Parameters
Get-Help # command 
help # alias, pipes through more

help *service*
help about*
help about_Aliases

help *breaking*
help *bits*

# help views
help dir
help dir -Examples
help dir -Full
help dir -Online

help Get-Help -Online

Update-Help

# help can be shipped to computers that have no internet connection
help Save-Help
## 2. Parameter Sets

# what is parameter set?
help Get-EventLog # 2 parameter sets. -List parameter is related to only one of them.

Get-EventLog Security -Newest 10
Get-EventLog -List 

# parameters start with "-"
# accepted values are mentioned straight after parameters. Triangle brackets

## 3. Optional and Required Parameters

# optional parameters - square brackets.
# pay attention to what do the square brackets mark

## 4. Parameter Values

## 5. Positional and Named Parameters
Get-EventLog security -Newest 10
Get-EventLog -Newest 10 Security 

# square brackets

# positional
# arrays

Get-EventLog -LogName Security -Newest 5 -ComputerName client, dc

# why use named parameters?

## 6. Cheating

# tab autocompletion
# intellisense

Get-EventLog -?

# check full help for parameter attributes
help Get-EventLog -Full

help dir -ShowWindow

Show-Command -Name Get-EventLog

