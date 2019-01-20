<# 24. ADVANCED REMOTING AND PASSING DATA #>

## 1. Working with output (try to remote all of your processing). PowerShell remoting vs. BlackMagic

# invoke command warmup. what members do we have? why so many? Note the "Deserialized" part. (only properties and only 1 method)
# HTTP / XML
Invoke-Command -ScriptBlock {
  Get-EventLog -LogName Security -Newest 10
} -ComputerName dc.lab.pri, member.lab.pri | Get-Member

# let us compare that to the non PS Remoting variant ( black magic :)
# RPC (maybe) / Text / demo - stop/start firewall
Get-EventLog -LogName Security -Newest 10 -ComputerName dc.lab.pri, member.lab.pri | Get-Member

# try to stop process with the black magic way
help -Name Get-Process
Get-Process -ComputerName member.lab.pri -Name ServerManager | Stop-Process

# try another way
Invoke-Command -ScriptBlock {
  Get-Process -Name ServerManager
} -ComputerName member.lab.pri | Stop-Process

# explain why the above error. explain ByValue and ByName scenarios
help -Name Stop-Process -Full

# and now try another way, this time try to execute everything on the remote computer
Invoke-Command -ComputerName member.lab.pri -ScriptBlock {
  Get-Process -Name ServerManager | Stop-Process
}

# another example. what is wrong here?
Invoke-Command -ScriptBlock {
  Get-Process
} -ComputerName dc.lab.pri |
Sort-Object -Property vm -Descending |
Select-Object -First 10 |
Format-Table -Property Id, Name, VM -AutoSize

# a better solurion is this:
Invoke-Command -ScriptBlock {
  Get-Process |
  Sort-Object -Property vm -Descending |
  Select-Object -First 10 
} -ComputerName dc.lab.pri | Format-Table -Property id, name, vm -AutoSize

# now the above commands against 2 computers!
Invoke-Command -ScriptBlock {
  Get-Process
} -ComputerName dc.lab.pri, member.lab.pri |
Sort-Object -Property vm -Descending |
Select-Object -First 10 |
Format-Table -Property Id, Name, VM, pscomputername -AutoSize

Invoke-Command -ScriptBlock {
  Get-Process |
  Sort-Object -Property vm -Descending |
  Select-Object -First 10 
} -ComputerName dc.lab.pri, member.lab.pri | Format-Table -Property id, name, vm, pscomputername -AutoSize

## 2. Passing input arguments from local variables

# initial example. what is wrong?
$logname = Read-Host -Prompt 'Enter log name to retrieve'
Invoke-Command -ComputerName dc.lab.pri, member.lab.pri -ScriptBlock {
  Get-EventLog -LogName $logname -Newest 10
}

# here is how to pass arguments in invoke-command scriptblock - the correct way. PS v2
$logname = Read-Host -Prompt 'Enter log name to retrieve?'
$quantity = Read-Host -Prompt 'How many entries to retrieve?'
Invoke-Command -ComputerName dc.lab.pri, member.lab.pri -ScriptBlock {
  param($x,$y) Get-EventLog -LogName $x -Newest $y
} -ArgumentList $logname, $quantity

# here is how to pass arguments in invoke-command scriptblock - the correct way. PS v3 syntax with 
# $using:localVariableName
$logname = 'system'
$quantity = 10
Invoke-Command -ComputerName dc.lab.pri, member.lab.pri -ScriptBlock {
  Get-EventLog -LogName $using:logname -Newest $using:quantity
} -ArgumentList $logname, $quantity
