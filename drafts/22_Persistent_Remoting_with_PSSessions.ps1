<# 22. PERSISTENT REMOTING WITH PSSESSIONS #>

## 1. Basic session management

# demo enter-pssession
Enter-PSSession -ComputerName dc.lab.pri
Get-Process # note there is a PowerShell process started - wsmprovhost
exit

# demo with -computername key. Notice there is no wsmprovhost process - no PowerShell remoting.
Get-Process -ComputerName dc.lab.pri

# demo with invoke-command cmdlet
Invoke-Command -ScriptBlock { Get-Process } -ComputerName dc.lab.pri

# cleanup
Get-PSSession | Remove-PSSession

# work with remote sessions without placing them in variables
Enter-PSSession -ComputerName dc.lab.pri
# run this in another powershell console: Get-Process -ComputerName dc.lab.pri

## 2. Disconnedted sessions in PS 3.0+

# leave a session up and running
$dc = New-PSSession -ComputerName dc.lab.pri
$computers = New-PSSession -ComputerName dc.lab.pri,member.lab.pri
Get-PSSession 

# how to re-use them 
Enter-PSSession -Session $dc
Get-Process # notice there are 2 session processes
exit
Get-PSSession

# why this does not work? 
Enter-PSSession -Session $computers

# same with invoke command - run a command on several remotes at same time
Invoke-Command -Session $computers -ScriptBlock { dir c:\users }

# remove a session - why this does not work?
$session | Remove-PSSession

# remove the correct sessions:
$computers | Remove-PSSession


# or simply close the PowerShell console. sessions are not between copies of powershell
# but try to be good and remove the sessions. do not leave garbage.
Get-PSSession | Remove-PSSession

## 3. Using sessions

# if we do not care and have many sessions opened to same computer
Enter-PSSession -Session ( Get-PSSession -ComputerName dc.lab.pri | Select-Object -First 1 )
exit

# disconnecting PSSession
Get-PSSession | Select-Object -First 1 | Disconnect-PSSession
Get-PSSession # note the state of the session

# find the disconnected sessions
Get-PSSession
Get-PSSession -ComputerName dc.lab.pri

# reconnect to a session. we have to disconnect specifically beforehand
Get-PSSession -ComputerName dc.lab.pri | Connect-PSSession
Get-PSSession -ComputerName dc.lab.pri | Select-Object -First 1 | Enter-PSSession
exit
Get-PSSession | Remove-PSSession
