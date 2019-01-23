## 1. Importing modules and snapins

# snap-ins vs modules
# working with snap-ins
Get-PSSnapin -Registered # shows registered snap-ins
Get-PSSnapin # shows all snap-ins available on the system
Add-PSSnapin [Name] # load a snap-in
Add-PSSnapin Microsoft.SharePoint.PowerShell # example

# no autodiscovery

# working with modules
Get-Module # shows all loaded modules
Get-Module -ListAvailable # shows available modules, it looks for them in specific locations
Import-Module -Name [Name] # loads a module
Import-Module -Name TroubleshootingPack # import module example

$env:PSModulePath

# autodiscovery

# every PS console window is a different environment!


## 2. Searching for commands
Get-Command -Module TroubleshootingPack # shows all cmdlets from specific module (v2 vs v3)
Get-Command -Name *pack* # filter example
Get-Command -Name *pack* -CommandType Cmdlet, Function
Get-Command -Name *servic* # pay attention to string pattern matches
Get-Command -Verb get -Noun *serv*
Get-Command -Verb stop
Get-Command -Verb stop

Get-NetAdapter # tab completion in v2 vs v3 # explicit vs implicit module loading

# prefixes
Get-Command -Noun Net*

# PowerShell console history and shortcuts


# naming convention - verb/sungular noun
Get-Verb

# why is the verb naming convention? whey there is no noun naming convention?

# aliases
Get-Alias

## 3. GUI / Discoverability features

## 4. The "cmdlet" keyword

# google search cmdlet + action