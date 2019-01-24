## What is a PSProvider

# PS v2
dir; mkdir; rmdir;
# hierarchical databases
# file system, registry, IIS sites/pools
Get-PSProvider

# think of adapters

## What is a PSDrive
Get-PSDrive

## Discoverability
Get-Command -Noun PSDrive

## Mapping a new drive
New-PSDrive -Name Win -PSProvider FileSystem -Root C:\Windows

## Navigating a drive
Get-Command -Noun item*

## Working with items
Get-Help Get-ChildItem
Get-Help New-Item
Get-Help New-PSDrive

# notice the command does not have an idea about the storage system
# notice psprovider capabilities
dir -Path C:\Windows -Recurse -Filter *.dll
dir -Path HKCU:\Software -Recurse -Filter win*

# providers have help
help FileSystem
help Registry

# iis example
# ad example

## Working with item properties
dir C:\Windows
dir HKCU:\Software

# read only vs changeable properties
Get-ItemProperty C:\Windows
Get-ItemProperty C:\Windows | Select-Object -Property *

"test" | Out-File c:\test.txt
Get-ItemProperty -Path c:\test.txt | Select-Object -Property *
Set-ItemProperty -Path C:\test.txt -Name IsReadOnly -Value $true
Set-ItemProperty -Path C:\test.txt -Name Name -Value "test2.txt"

## Technologies that use it and credential convenience

# iis, ad, which else?