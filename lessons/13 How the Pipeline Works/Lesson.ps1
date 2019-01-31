## Passing data from one command to next
Get-Process -Name notepad | Stop-Process # how does this miracle work?

# how does this work in Unix?
# standard in / standard out / error

# how does this work in PowerShell?
# ByValue (primary plan)

# command1 | command2 -parameter1 [value] -parameter2 [value]
# think of datatypes

Get-Process | gm
help Stop-Process # can you spot a parameter, that accepts a collection of objects? does it accept input from pipeline?

Get-Service | Stop-Process # this does not make sense. Why?
Get-Service | gm
help Stop-Process # notice -Id and -Name parameter
help Stop-Service

# ByPropertyName (fallback plan)

Get-Service | gm -MemberType *property # do we have a match with any of the input object properties?
Get-Service | Stop-Process -WhatIf

## Renaming properties in the pipeline

# csv contents | management or reporting task, like get-service, or restart-computer
# easy scenario
Import-Csv -Path c:\computers.csv | Get-Process 
# not-so-easy scenario
Import-Csv -Path c:\computers.csv | Select-Object | Get-Process 

# overriding parameters explicitly
Import-Csv -Path c:\computers.csv | Get-Process -ComputerName client

Import-Csv -Path c:\computers.csv | Get-Service
Import-Csv -Path c:\computers.csv | Get-Service -Name *

## Parentheticals
Get-EventLog -LogName Security -Newest 5 -ComputerName (Import-Csv c:\computers.csv)

## Expanding property values
Get-EventLog -LogName Security -Newest 5 -ComputerName (Import-Csv c:\computers | Select-Object -Property machine)
Get-EventLog -LogName Security -Newest 5 -ComputerName (Import-Csv c:\computers | Select-Object -ExpandProperty machine)

# note to myself.
#computername, os, ip
