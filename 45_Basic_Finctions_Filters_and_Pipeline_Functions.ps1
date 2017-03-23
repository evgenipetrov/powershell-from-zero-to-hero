<# 45. BASIC FUNCTIONS FILTERS AND PIPELINE FUNCTIONS #>

## 1. Basic Functions

# let us pick a command. Test it! The command itself is not important, the important bit is to build around it.
Get-WmiObject -Class win32_computersystem -ComputerName dc | Select-Object Name, Manufacturer, Model

# Immediately save the command to a file - it is important to format it well. It is also important to spell out the entire commands and parameters
gc -Path C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_45\function.v0.1.ps1

# make it a function 
# fix the formatting to maximize the readability. Indent. Do not be worried if the name gets too long. There are aliases.
gc -Path C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_45\function.v0.2.ps1

#  now let us run it. why nothing happens?
C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_45\function.v0.2.ps1

# proof the script is running
gc -Path C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_45\function.v0.3.ps1
C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_45\function.v0.3.ps1

# try to run the function. why the error? Scopes.
Get-ComputerSystemInfo

# resolve the issue with dot sourcing. Now try to run the function again. It is in the function drive (global shell). What are the downsides ? 
. C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_45\function.v0.3.ps1
Get-ComputerSystemInfo
dir function:

#  avoid the downsides from above method by running the function in the end of the script
gc -Path C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_45\function.v0.4.ps1
C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_45\function.v0.4.ps1

# what are the downsides of the above method? It cannot be parametrised. This is how to avoid that.
gc -Path C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_45\function.v0.5.ps1
C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_45\function.v0.5.ps1

# can it accept pipeline input?
gc -Path C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_45\function.v0.6.ps1
C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_45\function.v0.6.ps1

## 2. Filters

# the filters save us some effort of analyzing the input etc. multithreaded approach
gc -Path C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_45\function.v0.7.ps1
C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_45\function.v0.7.ps1


## 3. Pipeline input. Any PowerShell version.

# example for better approach. The process block executes once per every object coming from the pipeline.
# begin and end are good for setup and cleanup. example - open and close a database connection.

gc -Path C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_45\function.v0.7.ps1
C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_45\function.v0.7.ps1

