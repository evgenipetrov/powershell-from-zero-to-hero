<# 16. ADVANCED OPERATORS #>

# help about_operators

## 1. Is and As

# check against a particular datatype?
'hello' -is [string]

# is it integer?
'hello' -is [int]

# reverse the logic
'hello' -isnot [string]

# casting
'hello' -as [int]

# let us cast a string containing numbers
'555' -as [int]

# cast a mixed string - letters and numbers
'123abc456' -as [int]

## 2. Contains and In

# what is the output of the following command?
'powershell' -contains 'shell'

# what about the following?
'powershell' -like '*shell'

# the contains operator is made for checking arrayelements
'one', 'two', 3, 'four' -contains 3

# we can invert the logic
'one', 'two', 3, 'four' -notcontains 'four'

# PS 3.0+ allows even more  inverted logic
10 -in 1, 2, 3, 4, 5, 6, 7, 8, 9, 10

## 3. Replace, Split and Join

# make an array and join elements with ","
$arr = 1, 2, 3, 4, 5
$arr
$list = $arr -join ','
$list

# how can we access the $list elements ?
$list[0]

# what will the output be?
$list[1]

# convert the list back to array
$arr2 = $list -split ','
$arr2

# how do we make an array with only 1 member?
$arr = ,1

# or alternatively
$arr = @()
$arr += 1

# replace
'powershell' -replace 'l', 'x'

## 4. Math and Assignment

# add number to variable
$var = 5 + 5
$var += 5

# math with string does not work
$var = 'hello'
$var -= 'test'

# only concatenation
$var = 'hello'
$var += ' test'

# increments decrements
$var = 5
$var++

## 5. Bitwise

# 1 2 4 8 16 32 64 128

# 1 0 1 1 0  0  0  0 = 13
# 0 1 0 1 0  0  0  0 = 10

# add numbers
7 -band 10

# substract 
7 -bor 10

# AD bitwise flags - account enabled, user 


## 6. Boolean

# what will this expression return?
(5 -gt 10) -and (4 -lt 6) -or $true

## 7. Redirection

# redirect like in old times
Get-ChildItem > dir.txt

# same as 
Get-ChildItem | Out-File -FilePath dir.txt

# append like in old times
Get-ChildItem >> dir.txt

# same as 
Get-ChildItem | Out-File -FilePath dir.txt -Append

# redirect the errors
Remove-Item -Path c:\nothing 2> erorr.txt

## 8. Dot Sourcing

# make a script and include it
@"

function test{
    Write-Host "hello"
}

"@ | Out-File -FilePath functions.ps1

. .\functions.ps1 # the dotsourcing thing itself

test

## 9. Range

# one to 100
1..100

# 6 / 49 winning numbers
1..49 | Get-Random 

## 10. Formatting

# let us format some string like real programmers
'Today is a {0} day, tomorrow will be even {1}. {3}' -f 'bad', 'worse', 'test', ':)'

## 11. Arrays

# define an array
$arr = 1, 2, 3, 4, 5

# get array element per specific index
$arr = 1, 2, 3, 4, 5
$arr[2]

# add elements to array
$arr = 1, 2, 3, 4, 5
$arr += 'six', 'seven'
$arr
