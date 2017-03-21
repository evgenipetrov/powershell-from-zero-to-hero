<# 41. PROMPTING FOR INPUT AND PRODUCING OUTPUT #>

## 1. What is Output in PowerShell terms?

# there are several ways to provide information. 5 of them are pipelines


Write-Output 'Hello'
Write-Verbose 'Hello'
Write-Debug 'Hello'
Write-Warning 'Hello'
Write-Error 'Hello'

## 2. Write Host, Output, Verbose, etc

# write-host vs write-output
Write-Host '123456789' | Where-Object {$_.Length -gt 10}
Write-Output '123456789' | Where-Object {$_.Length -gt 10}

# get vs show verbs. pay attention to file names and command names.

# what about the rest pipelines?
Write-Verbose "Hello"

# output by default the verbose info on the screen
$VerbosePreference = "Continue"
Write-Verbose "Hello"

# what are all preferences set to by default?
dir variable:\ -Name *preference

# try another way
dir variable:\ | Where-Object {$_.Name -like "*preference"}

## 3. Read Host

# example prompt for information
Read-Host "Enter something"

# check what goes to which pipeline
Read-Host "Enter something" | Where-Object {$_.Length -gt 10}

# it is easy to put that input into variable
$var = Read-Host "Enter something"



