## Basic session management

Enter-PSSession -ComputerName dc
# note the wwsmprovhost process
Get-Process

Invoke-Command -ScriptBlock {Get-Process} -ComputerName dc
# this is not powershell remoting
Get-Process -ComputerName dc

## Disconnected sessions

Get-PSSession

Disconnect-PSSession # retains sessions.
Connect-PSSession # no way to connect to other people's sessions

# sessions are not shared between PS consoles

## Using sessions

$session = New-PSSession -ComputerName dc
$sessions = New-PSSession -ComputerName dc,member

help Enter-PSSession
Enter-PSSession -Session $session

Invoke-Command -ScriptBlock { dir c:\ } -Session $sessions

$sessions | Remove-PSSession # vs simply closing PS console