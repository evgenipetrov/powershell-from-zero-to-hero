<# 23. IMPLICIT REMOTING AND USING COMMANDS ON ANOTHER COMPUTER #>

## 1. Start a session

# a reminder: enter a session and exit
Enter-PSSession -ComputerName dc.lab.pri
exit 

# show all alailable modules on the client machine. Note there are no AD cmdlets available
Get-Module
Get-Module -ListAvailable
Get-Command -Noun AD*

## 2. Ask it to load a module into memory

# start sessions to dcs
$dc = New-PSSession -ComputerName dc.lab.pri
$rdc = New-PSSession -ComputerName rdc.remote.pri -Credential remote\administrator
Get-PSSession

# load active directory module on these machines
Invoke-Command -Session $dc,$rdc -ScriptBlock { Import-Module ActiveDirectory }

# now load the commands (shortcuts) locally
Import-PSSession -Session $dc -Prefix LAB -Module ActiveDirectory
Get-Command -Noun AD*
Get-Command -Noun LAB*

# try to get some users
Get-LABADUser -Filter *

# do the same again with the remote trusted domain
Import-PSSession -Session $rdc -Prefix REMOTE -Module ActiveDirectory
Get-Command -Noun *aduser* # notice commands from both imports

# what is the differense
Get-LABADUser -Filter *
Get-REMOTEADUser -Filter *
 
# remove the sessions and the commands
Get-PSSession | Remove-PSSession
Get-Command -Noun AD*
Get-Command -Noun LAB*


