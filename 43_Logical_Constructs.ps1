<# 43. LOGICAL CONSTRUCTS #>

## 1. If

# example 
$procs = Get-Process
if($procs.count -gt 100) {
    Write-Host "You have a lot of processes"
}

# example for else construct
$procs = Get-Process
if($procs.count -gt 100) {
    Write-Host "You have a lot of processes"
} else {
    Write-Host "You have less than 100 processes."
}

# example for else construct
$procs = Get-Process
if($procs.count -gt 100) {
    Write-Host "You have a lot of processes"
} elseif ($procs.count -lt 5) {
    Write-Host "You have very few processes."
} else {
    Write-Host "You have less than 100 processes."
}

# only the first matching conditional will execute
$procs = Get-Process
if($procs.count -gt 100) {
    Write-Host "You have a lot of processes"
} elseif ($procs.count -lt 5) {
    Write-Host "You have very few processes."
} elseif ($procs[0].Name -notlike "z*") {
    Write-Host "Your first process does not start with 'z'"
} else {
    Write-Host "You have less than 100 processes."
}

## 2. Switch