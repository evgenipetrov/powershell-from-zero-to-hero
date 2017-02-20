<# 16. ADVANCED OPERATORS #>

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
'one','two',3,'four' -contains 3

# we can invert the logic
'one','two',3,'four' -notcontains 'four'

# PS 3.0+ allows even more  inverted logic
10 -in 1,2,3,4,5,6,7,8,9,10

## 3. Replace, Split and Join

## 4. Math and Assignment

## 5. Bitwise

## 6. Boolean

## 7. Redirection

## 8. Dot Sourcing

## 9. Range

## 10. Formatting

## 11. Arrays