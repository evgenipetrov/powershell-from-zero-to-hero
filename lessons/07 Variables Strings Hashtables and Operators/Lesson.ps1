## Variables

$var = 'hello'
dir Variable:

Get-Command -Noun Variable

# $ is a dereferencing operator
# think of it as a box and label
# var is the box label, $var is the content

New-Variable -Name $var -Value 'bye'
$var

New-Variable -Name var -Value 'bye'

$this_is_another_variable = 5

${and this is another variable} = 10

dir Variable:
## Quotes

$a = "say $var"
$b = 'say $var'

cd 'C:\Program Files'
cd C:\Program Files

## Hashtables

$h = @{
    'key1' = 'value1'
    'key2' = 'value2'
}

$h['key2']
$h

## Here strings
$example = @"

$var

$var

test

"@ # important to be at the very first position of the line

## Escape characters

$c = "say `$var"
$d = 'say `$var'
$e = "say `$var `n`n hi"
cd C:\Program` Files

$query = "SELECT * from $table WHERE 'name' = $name"

## Arrays and Collections

$services = Get-Service
$services.GetType()

$services[0]
$services[0].Name

## Math operators

5 + 5
5 - 5
5 * 5
5 / 5

5 + $var
5 - $var

## Variable types

$x = 5
$y = '5'

$x + $y
$y + $x

$x.GetType()
$y.GetType()

$repeat = Read-Host -Prompt "How many times to repeat?"
$repeat
$repeat.GetType()

[int]$repeat = Read-Host -Prompt "How many times to repeat?"

[string]$a = 5
[int]$b = 5

[bool]$c = $true

## Subexpressions

Write-Host "this is my important service $services[0].Name"
Write-Host "this is my important service $($services[0].Name)"