## Is and As

$x = 'hello'
$x -is [string]
$x -is [int]

$x -as [int]
45.443 -as [int]
45.777 -as [int]

$x = '345'
$x -as [string]
$x -as [int]
$y = $x -as [int]
$y | gm
$x | gm
$y -isnot [string]

## Contains and In

# contains vs like
$x = 1,2,3,4,5,'one','two'
$x -contains 2
$x -contains 'three'
$x -notcontains 'two'

# v3+
2 -in $x

## Replace, Split, Join

$x = 'windows'
$x -replace 'i', 'l'
$x

$a = 1,2,3,4,5,6,7,8
$a
$a[5]
$a[-1]
$a[-2]

$a = $a + 9
$a

$a += 10
$a

$a -join ','
$a -join ',' | gm

$b = $a -join ','
$b -split ','
$b -split '6'

$a = ,5

## Math and Assignment

$x = 10
$x + 5
$x += 5
$x / 2
$x *= 10

$x++
$x += 1

## Boolean
(5 -gt 1) -and (5 -lt 10)
(5 -gt 1) -and (5 -lt 1)

(5 -gt 1) -or (5 -lt 10)
(5 -gt 1) -or (5 -lt 1)

(5 -gt 1) -xor (5 -lt 10)
(5 -gt 1) -xor (5 -lt 1)

-not (5 -gt 1) -xor (5 -lt 1)
! (5 -gt 1) -xor (5 -lt 1)

-not 'test'

## Redirection

dir > c:\dir.txt
dir | Out-File c:\dir.txt

dir >> c:\dir.txt
dir | Out-File c:\dir.txt -Append

del c:\nonexistent.txt
del c:\nonexistent.txt 2> c:\error.txt

## Dot sourcing

. 'C:\Projects\PS Training\lessons\16 Advanced Operators\files\functions.ps1' # modules are better.

$PSScriptRoot

## Range
1..20
1..20 | Get-Random

1..100 | ForEach-Object {dir}

## Formatting
"{0} {1:N2} {3} {2}" -f "hello","12.3456","test","bye"
"{0} {1:N2} {3} {2}" -f "hello",12.3456,"test","bye"

