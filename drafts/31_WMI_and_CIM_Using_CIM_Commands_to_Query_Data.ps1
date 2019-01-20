<# 31. USING CIM COMMANDS TO QUERY DATA #>

## 1. Getting CIM objects

# CIM is only available in PS v3.0+ 
Get-Command -Noun cim*

# Class definition vs Objest
help Get-CimClass
help Get-CimInstance

# demo
Get-CimClass -ClassName win32_bios | Select-Object -Property *

# expand the proprties. note lots are read only. why?
Get-CimClass -ClassName win32_bios | Select-Object -ExpandProperty CimClassProperties

# tab completion works to some extent
Get-CimClass -Namespace root/SecurityCenter2 -ClassName AntiSpywareProduct

# this class is not documented. let us try to obtain more information
Get-CimClass -Namespace root/SecurityCenter2 -ClassName AntiSpywareProduct | Select-Object -ExpandProperty cimclassproperties

# try the ciminstances
Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntiSpywareProduct 

# get all the properties of the cim instance
Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntiSpywareProduct | Select-Object *

# compare it to wmi objects
Get-WmiObject -Namespace root/securitycenter2 -class antispywareproduct | Select-Object *

## 2. Getting instances

# connect to PS v2.0. mind the firewall
Get-WmiObject -ComputerName win7.lab.pri -Class win32_bios
Get-CimInstance -ComputerName win7.lab.pri -ClassName win32_bios

## 3. Working with command options

## 4. working with output

# try to retrieve  only one property
Get-CimInstance -ClassName Win32_BIOS -Property SerialNumber

## 5. Communication is based on WS-MAN


