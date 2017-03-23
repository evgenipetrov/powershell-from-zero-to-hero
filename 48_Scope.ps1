<# 48. SCOPE #>

## 1. What is Scope?

# global scope, script scope, function scope
gc -Path C:\Projects\powershell-from-zero-to-hero\Scripts\Lesson_48\scope.ps1

# try the script in a new powershell window.

## 2. Working outside of your scope
 
# syntax 1
Set-Variable -Name z -Scope global -Value 1000

# syntax 2
$Global:z = 500 # very poor practice

# what issue does the poor practice solve? how can it be solved in a neat way?

# aliases have scopes too.
