## Getting the syntax right

help *proc*
Get-Command -Noun get -Verb *proc*

Get-Process # the first parameter set is the default one.
Get-Help Get-Process

Get-Process -Name s* # wildcards
Get-Process -ComputerName client, dc, member
Get-Process -ComputerName client, dc

Get-Process taskhost
get-process -Name taskhost
Get-Process -Id 1136
Get-Process 1136

help Get-Process

## Using aliases
Get-Alias
Get-Alias dir
Get-Alias ls
get-alias get-childitem
Get-Alias -Definition get-childitem

ps
gps
Get-Help Get-Process -Full

# alias creation
New-Alias -Name d -Value get-childitem # remember environment limitations.

Get-Command -Noun alias

## Parameter shortcuts

# hit tab vs truncation. when is OK?

# which one is better to read? what is the cost of making it more readable?
Get-Process -n task* 
Get-Process -Name task*


Get-Process -i 1234

## External commands

ping 8.8.8.8
Get-Alias ping
get-alias dir
