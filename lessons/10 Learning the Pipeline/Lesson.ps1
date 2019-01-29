## What is in the pipeline?
Get-Process
Get-Process | Stop-Process -WhatIf
Get-Process | Out-File c:\temp.txt
Get-Process | Export-Csv c:\process.csv
Get-Content c:\process.csv # does not try to interpret the file
Import-Csv | c:\process.csv # does try to interpret the file

# think of the pipeline like as of a pipe full of objects (or not)

# command1 -> (output objects) -> | (input objects) command2 (output objects)

# out default
Out-Default
Out-Host

# commands that don't send any output objects

## Import, Export, Convert 
Get-Process | Export-Csv c:\process.csv
Get-Process | ConvertTo-Csv
Get-Process | ConvertTo-Csv | Out-File c:\process.csv
Import-Csv | c:\process.csv

## CSV, CliXML, HTML
Get-Process | Export-Csv c:\process.csv # note the collections, because of the flat structure
Get-Process | Export-Clixml c:\process.xml # hierarchical structure
Import-Clixml c:\process.xml

Get-Process | Export-Clixml c:\baseline.xml
Compare-Object -ReferenceObject (Import-Clixml c:\baseline.xml) -DifferenceObject (Get-Process) -Property Name

Compare-Object -ReferenceObject (Import-Clixml c:\baseline.xml) -DifferenceObject (Get-Process) -Property Name | ConvertTo-Html | Out-File c:\differences.html

Get-EventLog -LogName Security -Newest 10 | Export-Csv c:\security.log | Out-File c:\something.csv

