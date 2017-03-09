<# 30. USING WMI COMMANDS TO QUERY DATA #>

## 1. The Repository

# demo - mmc -> WMI Control snap-in

# WMI Explorer: https://powershell.org/2013/03/08/wmi-explorer/

# Sapien WMI explorer : https://www.sapien.com/software/wmiexplorer

## 2. Exploring the Repository

## 3. Finding Documentation

# https://msdn.microsoft.com/en-us/library/aa394418(v=vs.85).aspx

## 4. WMI vs. CIM

## 5. Finding classes in PowerShell

# show me everything
Get-WmiObject -Namespace root\cimv2 -List

# get one class instances
Get-WmiObject -Namespace root\cimv2 -Class Win32_Service | Format-Table -AutoSize

# try to find instances for disk management
Get-WmiObject -Namespace root\cimv2 -List | Where-Object { $_.name -like "*disk*" }






