<# 00. COMPLETING A PRACTICAL TASK #>

## 0. Task

# get a list of installed roles and features from a windows server computer remotely
# save that list of installed features to a file of some kind. 
# retain the ability to query that server again and see if somebody has installed anything additional on the computer.

## 1. Discover commands

## 2. Learn new stuff

## 3. Experiment

## 4. Revise

## 5. Complete the task



























## task solution

# subtask 1: how to get a list of installed features and roles on a computer
help role
help feature

# see what other commands we have on that module
Get-Command -Module ServerManager # note the alias new -> install. note the ComputerName parameter

# see some help for the suspected command
help Get-WindowsFeature 

# test the command
Get-WindowsFeature -ComputerName member

# try to troubleshoot
ping member
ping dc

# test the command on a resolvable computer
Get-WindowsFeature -ComputerName dc # note the space in the install state. note the isInstalled property

# see if we can pull the installed features by the noticed property 
Get-WindowsFeature -ComputerName dc | where { $_.isInstalled }

# check the uninstallation possibilities
help Uninstall-WindowsFeature # how to uninstall

# see if uninstall cmdlet can accept feature by name
Get-WindowsFeature -ComputerName dc | where { $_.isInstalled } | Export-Clixml c:\temp\feature-baseline.xml

# check the baseline import
Import-Clixml -Path c:\temp\feature-baseline.xml

# add a test feature 
Install-WindowsFeature -Name telnet-client -ComputerName dc

# try to detect the difference
Compare-Object -ReferenceObject (Import-Clixml c:\temp\feature-baseline.xml) -DifferenceObject (Get-WindowsFeature -ComputerName dc)

# try to compare only the names
Compare-Object -ReferenceObject (Import-Clixml c:\temp\feature-baseline.xml) -DifferenceObject (Get-WindowsFeature -ComputerName dc) -Property name 

# now we have the list of names of features to uninstall, let us try it
Uninstall-WindowsFeature -ComputerName dc -Name (Compare-Object -ReferenceObject (Import-Clixml c:\temp\feature-baseline.xml) -DifferenceObject (Get-WindowsFeature -ComputerName dc) -Property name)

# try to find the feature
Get-WindowsFeature | where { $_.isInstalled }

# try to make it look easier to read
Uninstall-WindowsFeature -ComputerName dc -Name (

    Compare-Object -ReferenceObject (Import-Clixml c:\temp\feature-baseline.xml) -DifferenceObject (Get-WindowsFeature -ComputerName dc) -Property name
    
    )






