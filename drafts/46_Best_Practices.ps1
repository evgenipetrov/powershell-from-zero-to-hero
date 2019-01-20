<# 46. BEST PRACTICES #>

## 1. Worst practices and best practices. Focus on maintainability. Easy to read and easy to understand. Easy to navigate. Standarts.

# bad formatting. brackets.

function Get-ComputerSystemInfo  {
param(
   [string[]]$ComputerName)
BEGIN{}



PROCESS{
        
 if($_ -ne $null){
     $ComputerName = $_
 }

   foreach ($computer in $ComputerName){
       Get-WmiObject -Class win32_computersystem -ComputerName $computer | Select-Object -Property Name, Manufacturer, Model
        }

            }
    END{
}}

# there are 2 standards. pick one and stick to it

# standard 1 (closing should be on the same position of the logical block statement)
function this {

}

# standard 2 (closing should be on the same position as the opening bracket)
function this
{

}

# a good practice is to open and close immediately. see how easy is to read. the rule is: Always indent!
function this {
    if ($this -eq $that){
        foreach ($x in $collection){
            
        }
    }
}

# can you spot the issue fast ?
function this {
    if ($this -eq $that){
        foreach ($x in $collection){
            
            }
        }
    }
}

# now fix the example from the beginning.
function Get-ComputerSystemInfo  {
param(
   [string[]]$ComputerName)
BEGIN{}



PROCESS{
        
 if($_ -ne $null){
     $ComputerName = $_
 }

   foreach ($computer in $ComputerName){
       Get-WmiObject -Class win32_computersystem -ComputerName $computer | Select-Object -Property Name, Manufacturer, Model
        }

            }
    END{
}}

# these blocks are maaaaybe good for very large scripts where there is a lot of scrolling

##################################
####### GET THE WMI OBJECT #######
##################################
Get-WmiObject -Class win32_computersystem -ComputerName $computer | Select-Object -Property Name, Manufacturer, Model

# pay attention to color coding
Get-WmiObject -Class win32_computersystem -ComputerName $computer | 
    Select-Object -Property Name, Manufacturer, Model

# careful with backticks. they are simple escape characters and work only for the very next position.
Get-WmiObject `
    -Class win32_computersystem ` 
    -ComputerName $computer | 
 Select-Object 
    -Property Name, Manufacturer, Model


# splatting

foreach ($computer in $ComputerName) {
    $wmi_param = @{ 'Class'='Win32_LogicalDisk';
                    'Filter'="DriveType=3";
                    'Credential'='Administrator';
                    'ComputerName'='Computer'
                 }
    $select_param = @{'Property'='Name','Manifacturer','Model'}
    Get-WmiObject $wmi_param | Select-Object $select_param
}

# use source control.
