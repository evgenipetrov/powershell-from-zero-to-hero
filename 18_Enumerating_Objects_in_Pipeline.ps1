<# 00. ENUMERATING OBJECTS IN THE PIPELINE #>

## 1. ForEach

# get processes on a variable, pass them through the pipeline, do action
notepad.exe
notepad.exe
notepad.exe
$procs = Get-Process -Name notepad
$procs[0].Kill()
$procs[1].Kill()

# try to avoid using indexes
Start-Process -FilePath notepad.exe
Start-Process -FilePath notepad.exe
$procs = Get-Process -Name notepad

$procs | ForEach-Object -Process {
  $_.Kill() 
}

# -process parameter is positional
notepad.exe
notepad.exe
notepad.exe
$procs = Get-Process -Name notepad

$procs | ForEach-Object -Process {
  $_.Kill() 
}

# the bad people would use the aliases and no parameters in both commands
notepad.exe
notepad.exe

Get-Process -Name notepad | ForEach-Object -Process {
  $_.Kill() 
}

## 2. Performance considerations

# what happens under the hood
notepad.exe
notepad.exe
$procs = Get-Process -Name notepad

$procs | ForEach-Object -Process {
  $_.Kill() 
}

# this is faster
notepad.exe
notepad.exe
Get-Process -Name notepad | Stop-Process

# even faster
notepad.exe
notepad.exe
Stop-Process -Name notepad

# now can we tell that the above command is fastest ?
Measure-Command -Expression {
  notepad.exe
  notepad.exe
  notepad.exe
  Get-Process -Name notepad | ForEach-Object -Process {
    $_.Kill() 
  }
}
Measure-Command -Expression {
  notepad.exe
  notepad.exe
  notepad.exe
  Get-Process -Name notepad | Stop-Process
}
Measure-Command -Expression {
  notepad.exe
  notepad.exe
  notepad.exe
  Stop-Process -Name notepad
}

# really ? test 1
notepad.exe
notepad.exe
notepad.exe
Measure-Command -Expression {
  Get-Process -Name notepad | ForEach-Object -Process {
    $_.Kill() 
  }
}

# test 2
notepad.exe
notepad.exe
notepad.exe 
Measure-Command -Expression {
  Get-Process -Name notepad | Stop-Process 
}

# test 3
notepad.exe
notepad.exe
notepad.exe 
Measure-Command -Expression {
  Stop-Process -Name notepad 
}

## 3. Syntactical differences

# PS 3.0+
notepad.exe
notepad.exe
notepad.exe
Get-Process -Name notepad | ForEach-Object -Process {
  $PSItem.Kill() 
}

# simplified syntax
notepad.exe
notepad.exe
notepad.exe
Get-Process -Name notepad | ForEach-Object -MemberName Id

# same as 
notepad.exe
notepad.exe
notepad.exe
Get-Process -Name notepad | Select-Object -ExpandProperty Id

# shortening using the method. notice there are no parentheses
notepad.exe
notepad.exe
notepad.exe
Get-Process -Name notepad | Select-Object -Property kill

# potential problems and downsides
Get-Process | ForEach-Object -MemberName name.toupper

# performance test 4
notepad.exe
notepad.exe
notepad.exe 
Measure-Command -Expression {
  Get-Process -Name notepad | ForEach-Object -MemberName kill 
}