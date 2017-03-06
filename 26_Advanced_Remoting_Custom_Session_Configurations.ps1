<# 26. ADVANCED REMOTING AND CUSTOM SESSION CONFIGURATIONS #>

## 1. Setting up the group and a user

# create the ad group
Enter-PSSession -ComputerName dc.lab.pri
New-ADGroup -Name HelpDesk -GroupScope Global -GroupCategory Security -SamAccountName HelpDesk

# create a new user
Get-Help New-ADUser -ShowWindow
Get-Help New-ADUser -Full
New-ADUser -Name Jane -SamAccountName Jane -PasswordNeverExpires $true -AccountPassword (ConvertTo-SecureString -String 'demo!234' -AsPlainText -Force) -Department Help -Title Technician -City Sofia

# add the user to the group
Add-ADGroupMember -Identity HelpDesk -Members Jane

# verify the group members
Get-ADGroupMember -Identity HelpDesk

# we forgot to enable the accoun
Enable-ADAccount -Identity Jane

# while on the remote computer pick the commands to enable
Get-Command -Noun adaccount

## 2. Defining the session configuration

# create a new pssession configuration file
mkdir c:\Temp
New-PSSessionConfigurationFile -Path c:\Temp\helpdesk.pssc -ModulesToImport ActiveDirectory -VisibleCmdlets 'Enable-ADAccount','Unlock-ADAccount'

# let us see what is in the file. note the hashtable content format
gc C:\Temp\helpdesk.pssc

# hacker example. how to handle that?
Get-Process | Where-Object { mkdir c:\hackers }

# the language mode parameter. think about potential security issues with scriptblocks
Get-Help -Name New-PSSessionConfigurationFile -Parameter languagemode

## 3. Registering the configuration on the server

# get to local computer and generate SDDL. Why not on the remote machine ?
exit
Register-PSSessionConfiguration -Name test -ShowSecurityDescriptorUI

# get the SDDL
Get-PSSessionConfiguration -Name test | Format-List -Property *

# cleanup (and kick any remote users)
Unregister-PSSessionConfiguration -Name test

# now register the config on the DC machine
Enter-PSSession -ComputerName dc.lab.pri 
Register-PSSessionConfiguration



# test the configuration with the user


