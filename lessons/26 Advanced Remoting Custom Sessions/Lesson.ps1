## Delegated administration concept

# Setup
# Domain user and group

# remotely
New-ADGroup -Name HelpDesk -GroupScope Global -GroupCategory Security -SamAccountName HelpDesk
Get-ADGroup

New-ADUser -Name Joanne -SamAccountName Joanne -PasswordNeverExpires $true -AccountPassword (ConvertTo-SecureString -AsPlainText "demo!234" -Force) -Department Help -Title Technician -City Sofia
Get-ADUser
Set-ADUser -Identity Joanne -Enabled $true
Enable-ADAccount -Identity Joanne

Add-ADGroupMember -Identity HelpDesk -Members Joanne

# Define the session configuration

New-PSSessionConfigurationFile -Path c:\helpdesk.pssc -ModulesToImport activedirectory -VisibleCmdlets 'Enable-ADaccount','Disable-ADAccount'
Get-Content c:\helpdesk.pssc # note the hashtable ;)

# note language mode and caveats
help New-PSSessionConfigurationFile

# Register the configuration
# locally
Register-PSSessionConfiguration -Name test -ShowSecurityDescriptorUI
Get-PSSessionConfiguration -Name test | fl *
Unregister-PSSessionConfiguration -Name test
# remotely
# note sessiontype parameter
Register-PSSessionConfiguration -Path C:\helpdesk.pssc -name HelpDesk -SecurityDescriptorSddl "O:NSG:BAD:P(A;;GA;;;BA)(A;;GXGWGR;;;S-1-5-21-1890898889-3913056583-596830804-1110)S:P(AU;FA;GA;;;WD)(AU;SA;GXGW;;;WD)" -NoServiceRestart -RunAsCredential lab\administrator

# locally
Invoke-Command -ScriptBlock { Restart-Service WinRM } -ComputerName dc.lab.pri

# remotely
Get-PSSessionConfiguration
# Test
runas /user:lab\joanne "powershell"
Invoke-Command -ConfigurationName HelpDesk -ComputerName dc.lab.pri -ScriptBlock {enable-adaccount -identity jimmy}
Invoke-Command -ConfigurationName HelpDesk -ComputerName dc.lab.pri -ScriptBlock {remove-aduser -identity jimmy}
Invoke-Command -ConfigurationName HelpDesk -ComputerName dc.lab.pri -ScriptBlock {dir}
Enter-PSSession -ConfigurationName HelpDesk -ComputerName dc.lab.pri

# gui is better.