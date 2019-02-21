## Install and setup
Enter-PSSession -ComputerName member.lab.pri
add-windowsfeature windowspowershellwebaccess
Get-Command -module powershellwebaccess
help install-pswawebapplication
# pay attention to the certificate option

## Using PWA
add-pswaauthorizationrule -rulename 'default config for admins' -configurationname 'microsoft.powershell' -usergroupname 'lab\domain admins' -computername 'dc.lab.pri'


## Authentication issue solution
Enable-WSManCredSSP -Role client -DelegateComputer member.lab.pri # *.lab.pri
# check credSSP protocol in client folder

# on member
Enable-WSManCredSSP -Role Server

# on win10
Enter-PSSession -ComputerName member.lab.pri -Authentication Credssp # you must add username and passoword
Enter-PSSession -ComputerName member.lab.pri -Authentication Credssp -Credential lab\administrator

# on member
add-pswaauthorizationrule -rulename 'default config for admins' -configurationname 'microsoft.powershell' -usergroupname 'lab\domain admins' -computername 'dc.lab.pri'
