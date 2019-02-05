## ForEach

notepad;notepad;notepad
$procs = Get-Process -Name notepad
$procs

$procs | ForEach-Object -Process { $_.Kill() }
gps notepad | % {$_.kill()} # this is how you know bad people

## Performance cautions
$procs | ForEach-Object -Process { $_.Kill() }
$procs | Stop-Process
Stop-Process -Name notepad

Measure-Command -Expression { notepad; notepad; notepad; Get-Process -Name notepad | % { $_.kill() }}
Measure-Command -Expression { notepad; notepad; notepad; Get-Process -Name notepad | Stop-Process}
Measure-Command -Expression { notepad; notepad; notepad; Stop-Process -Name notepad}

# run 100 instances of notepad and measure again?




