## 1. Importing modules and snapins

# snap-ins vs modules
# working with snap-ins
Get-PSSnapin -Registered # shows registered snap-ins
Get-PSSnapin # shows all snap-ins available on the system
Add-PSSnapin [Name] # load a snap-in
Add-PSSnapin Microsoft.SharePoint.PowerShell # example

# working with modules
Get-Module # shows all loaded modules
Get-Module -ListAvailable # shows available modules, it looks for them in specific locations
Import-Module -Name [Name] # loads a module
Import-Module -Name TroubleshootingPack # import module example

# every PS console window is a different environment!


## 2. Searching for commands
Get-Command -Module TroubleshootingPack # shows all cmdlets from specific module
Get-Command -Name *pack* # filter example
Get-Command -Name *pack* -CommandType Cmdlet, Function
Get-Command -Name *service* 


# naming convention - verb/sungular noun
Get-Verb

## the "cmdlet" keyword

