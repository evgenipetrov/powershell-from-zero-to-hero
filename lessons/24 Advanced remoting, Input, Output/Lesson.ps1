## Output
# rule of thumb: process as much as you can on the remote machine

# static representation of a state snapshot.xml serialization strips out methods and retains only properties/values
Invoke-Command -ScriptBlock { Get-EventLog -LogName Security -Newest 10 } -ComputerName member,dc | gm

# no powershell remoting, live objects
Get-EventLog -LogName Security -Newest 10 -ComputerName member,dc | gm

Get-Process -ComputerName dc

Get-Process -ComputerName dc -Name dns | Stop-Process

Invoke-Command -ComputerName dc -ScriptBlock {Get-Process -Name dns} | Stop-Process

Invoke-Command -ComputerName dc -ScriptBlock {Get-Process -Name dns  | Stop-Process }

Invoke-Command -ComputerName dc -ScriptBlock { Start-Service -Name dns }

Invoke-Command -ComputerName dc -ScriptBlock { Get-Process } | sort vm -Descending | select -first 5 | Format-Table -Property id, name, vm -AutoSize
Invoke-Command -ComputerName dc -ScriptBlock { Get-Process | sort vm -Descending | select -first 5 } | Format-Table -Property id, name, vm -AutoSize

Invoke-Command -ComputerName dc, member -ScriptBlock { Get-Process } | sort vm -Descending | select -first 5 | Format-Table -Property id, name, vm -AutoSize
Invoke-Command -ComputerName dc, member -ScriptBlock { Get-Process } | sort vm -Descending | select -first 5 | Format-Table -Property id, name, vm, pscomputername -AutoSize

Invoke-Command -ComputerName dc, member -ScriptBlock { Get-Process | sort vm -Descending | select -first 5 } | Format-Table -Property id, name, vm -AutoSize
Invoke-Command -ComputerName dc, member -ScriptBlock { Get-Process | sort vm -Descending | select -first 5 } | Format-Table -Property id, name, vm, pscomputername -AutoSize

## Input

$logname = "Security"
$count = 10
Invoke-Command -ComputerName dc, member -ScriptBlock { Get-EventLog -LogName $logname -Newest $count }

# v2
Invoke-Command -ComputerName dc, member -ScriptBlock { param($x, $y) Get-EventLog -LogName $x -Newest $y } -ArgumentList $logname, $count

# v3+
Invoke-Command -ComputerName dc, member -ScriptBlock { param($l, $n) Get-EventLog -LogName $using:logname -Newest $using:count }
