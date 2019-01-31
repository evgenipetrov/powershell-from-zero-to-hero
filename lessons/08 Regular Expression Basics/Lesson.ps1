## RegEx resources

# http://regexlib.com/
# https://www.regextester.com/

# email examples
# ^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$
# ^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$

# special characters
# \d digits
# {4,5} how many characters
# \w letters
# [a-z] range
# \s space
# . wildcard

## The match operator
"abcd345" -match "\d"
"abcd345" -notmatch "\d"

"abcd345" -cmatch "[a-z]"
"abcd345" -cmatch "[A-Z]"

"abcd345fasdfa444" -match "\d+" # notice only the first sequence is matched
$Matches

# capturing
"abcd345fasdfa444" -match "[a-z]+(\d+)"
"abcd345fasdfa444" -match "([a-z]+)(\d+)"

"john.doe@yahoo.com" -match "(\w+)\.?"
$Matches[1]

"here is my email address john.doe@yahoo.com" -match "(\w+)\.?"
$Matches[1]

help about_Regular_Expressions

"john.doe@yahoo.com" -match "(?'name'\w+)\.?"
$Matches['name']

## The replace operator
"john.doe@yahoo.com" -replace "(\w+)\.?","x"

"Evgeni Petrov" -replace "(\w+)\s(\w+)", '$2 $1'
"Evgeni Petrov" -replace "([a-z]+)\s([A-Z]+)", '$2 $1'
"Evgeni Petrov" -creplace "([a-z]+)\s([A-Z]+)", '$2 $1'

# log files

## Selecting strings
"here is my email address john.doe@yahoo.com" | Select-String -Pattern "@"


