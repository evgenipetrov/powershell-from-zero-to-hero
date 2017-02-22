<# 00. ENUMERATING OBJECTS IN THE PIPELINE #>

## 1. ForEach

# get processes on a variable, pass them through the pipeline, do action
notepad;notepad;notepad
$procs = Get-Process -Name notepad
$procs[0].Kill()
$procs[1].Kill()

# try to avoid using indexes
Start-Process notepad.exe
Start-Process notepad.exe
$procs = Get-Process -Name notepad

$procs | ForEach-Object -Process { $_.Kill() }

# -process parameter is positional
notepad;notepad;notepad
$procs = Get-Process -Name notepad

$procs | ForEach-Object { $_.Kill() }

# the bad people would use the aliases and no parameters in both commands
notepad;notepad

ps notepad | % { $_.Kill() }

## 2. Performance considerations

# what happens under the hood
notepad;notepad
$procs = Get-Process -Name notepad

$procs | ForEach-Object -Process { $_.Kill() }

# this is faster
notepad;notepad;
Get-Process -Name notepad | Stop-Process

# even faster
notepad;notepad;
Stop-Process -Name notepad

# now can we tell that the above command is fastest ?
Measure-Command -Expression {notepad;notepad;notepad; Get-Process -Name notepad | ForEach-Object { $_.Kill() }}
Measure-Command -Expression {notepad;notepad;notepad; Get-Process -Name notepad | Stop-Process }
Measure-Command -Expression {notepad;notepad;notepad; Stop-Process -Name notepad }

# really ? test 1
notepad;notepad;notepad;
Measure-Command -Expression { Get-Process -Name notepad | ForEach-Object { $_.Kill() }}

# test 2
notepad;notepad;notepad; 
Measure-Command -Expression { Get-Process -Name notepad | Stop-Process }

# test 3
notepad;notepad;notepad; 
Measure-Command -Expression { Stop-Process -Name notepad }

## 3. Syntactical differences

# PS 3.0+
notepad;notepad;notepad;
Get-Process -Name notepad | ForEach-Object { $PSItem.Kill() }

# simplified syntax
notepad;notepad;notepad;
Get-Process -Name notepad | foreach Id

# same as 
notepad;notepad;notepad;
Get-Process -Name notepad | Select-Object -ExpandProperty Id

# shortening using the method. notice there are no parentheses
notepad;notepad;notepad;
Get-Process -Name notepad | Select-Object kill

# potential problems and downsides
Get-Process | ForEach-Object name.toupper()

# performance test 4
notepad;notepad;notepad; 
Measure-Command -Expression { Get-Process -Name notepad | ForEach-Object kill }