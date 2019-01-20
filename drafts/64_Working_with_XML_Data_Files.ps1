<# 64. ADVANCED SCRIPTING:WORKING WITH XML DATA FILES #>

## 0. Preparation: Adding custom module path

if (Get-Module -Name MyTools) 
{
  Remove-Module -Name MyTools
}

$customModulePath = 'C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_64\'
if ($env:PSModulePath -notlike "*$customModulePath*" )
{
  $env:PSModulePath = $env:PSModulePath + ";$customModulePath"
}

$env:PSModulePath

## 1. What is XML?

# see the sample file

## 2. Making an XML document

# see the sample file 

## 3. Manipulating XML in PowerShell

# read xml
[xml]$xml = Get-Content -Path 'C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_64\serverdata.xml'
$xml

# iterate with foreach
foreach ($computer in $xml.computers.computer)
{
  Write-Output -InputObject "Computer: $($computer.name)"
}

# Xpath
$node = $xml.SelectSingleNode("//server[@name='client.lab.pri']")
Write-Output -InputObject "The node name is '$($node.name)'"

# do something useful
foreach ($computer in $xml.computers.computer)
{
  $bios = Get-WmiObject -Class win32_bios -ComputerName $computer.name
  $biosserial = $bios.serialnumber
  
  $computer.biosserial = $biosserial
}

$xml.InnerXml

# save the xml to disk
[xml]$xml = Get-Content -Path 'C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_64\serverdata.xml'
foreach ($computer in $xml.computers.computer)
{
  # query information
  $bios = Get-WmiObject -Class win32_bios -ComputerName $computer.name
  $system = Get-WmiObject -Class win32_computersystem -ComputerName $computer.name 
  $os = Get-WmiObject -Class win32_operatingsystem -ComputerName $computer.name
  
  # update xml
  $computer.biosserial = $bios.serialnumber
  
  # create a new node
  $newNode = $xml.CreateNode('element','manufacturer','')
  $newNode.InnerText = $system.Manufacturer
  $computer.AppendChild($newNode) | Out-Null
  
  # create a new attribute
  $newAttribute = $xml.CreateAttribute('build')
  $newAttribute.Value = $os.buildnumber
  $null = $computer.SetAttributeNode($newAttribute)
}

$xml.Save('C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_64\serverdata-saved.xml')

# make a function

function Update-XMLInventory {
  [CmdletBinding()]
  param
  (
    [xml]
    [Parameter(Mandatory,ValueFromPipeline)]
    $xml,
    [string]$OutFilePath
  )
  foreach ($computer in $xml.computers.computer)
  {
  
    # query information
    $bios = Get-WmiObject -Class win32_bios -ComputerName $computer.name
    $system = Get-WmiObject -Class win32_computersystem -ComputerName $computer.name 
    $os = Get-WmiObject -Class win32_operatingsystem -ComputerName $computer.name
  
    # update xml
    $computer.biosserial = $bios.serialnumber
  
    # create a new node
    $newNode = $xml.CreateNode('element','manufacturer','')
    $newNode.InnerText = $system.Manufacturer
    $null = $computer.AppendChild($newNode)
  
    # create a new attribute
    $newAttribute = $xml.CreateAttribute('build')
    $newAttribute.Value = $os.buildnumber
    $null = $computer.SetAttributeNode($newAttribute)
  }

  $xml.Save($OutFilePath)
  
  
}

Get-Content 'C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_64\serverdata.xml' |
ConvertTo-Xml |
Update-XMLInventory -OutFilePath 'C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_64\serverdata-final.xml'