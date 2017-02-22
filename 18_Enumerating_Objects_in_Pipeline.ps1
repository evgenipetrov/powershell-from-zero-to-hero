<# 00. ENUMERATING OBJECTS IN THE PIPELINE #>

## 1. ForEach

# get processes on a variable, pass them through the pipeline, do action
Start-Process notepad.exe
Start-Process notepad.exe
$procs = Get-Process -Name notepad
$procs[0].Kill()
$procs[1].Kill()

# try to avoid using indexes
Start-Process notepad.exe
Start-Process notepad.exe
$procs = Get-Process -Name notepad

$procs | ForEach-Object -Process { $_.Kill() }

# -process parameter is positional
Start-Process notepad.exe
Start-Process notepad.exe
$procs = Get-Process -Name notepad

$procs | ForEach-Object { $_.Kill() }

# the bad people would use the aliases and no parameters in both commands
Start-Process notepad.exe
Start-Process notepad.exe

ps notepad | % { $_.Kill() }

## 2. Performance considerations

## 3. Syntactical differences


