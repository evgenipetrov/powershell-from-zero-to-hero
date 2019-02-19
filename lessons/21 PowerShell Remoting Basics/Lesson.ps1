## How does PS remoting work?
# always enabled for outgoing connections
# protocol: WS-MAN
# windows services: WinRM
# ports: 5985 for HTTP; 5986 for HTTPS 
# think XML packets, commands are packed, and responses are also packed (think serialized).

# 1:1 connections vs 1:N

# auth protocols:
# Kerberos for same domain, mutual authentication
# Kerberos for trusted domains, mutual authentication
# Basic protocol for untrusted domains. Cleartext credential transmissions. Therefore we have 2 options -
# 1. SSL->HTTPS . Downsides - PKI infrastructure.
# 2. Trusted hosts setting. 

## How to enable PS remoting manually

# Server 2012 and later have it enabled by default

Enable-PSRemoting

# SDDL

cd wsman:

Get-Command -Noun *wsman*

Connect-WSMan -ComputerName dc

ls dc

## Basic usage scenarios

Enter-PSSession -ComputerName dc.lab.pri 

exit

Invoke-Command -ScriptBlock {Get-EventLog -LogName Security -Newest 10} -ComputerName dc,member,localhost

help Invoke-Command

# double hop issue

cd WSMan:\localhost\Client\Auth
ls

cd WSMan:\localhost\Service\Auth
ls

help Enable-WSManCredSSP

# -Role server
# -DelegateComputer