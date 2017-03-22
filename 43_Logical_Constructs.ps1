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

# example for many ifs. this construct has an issue. can you spot it?
$disk = Get-WmiObject -Class win32_logicaldisk | select -First 1
if($disk.DriveType -eq 2){
    Write-Host "Drive is floppy"
} elseif ($disk.DriveType -eq 3){
    Write-Host "Drive is fixed"
} elseif ($disk.DriveType -eq 5){
    Write-Host "Drive is optical"
} else {
    Write-Host "Drive is other"
}
# what will happen if we have more than 1 disk?
$disk = Get-WmiObject -Class win32_logicaldisk
if($disk.DriveType -eq 2){
    Write-Host "Drive is floppy"
} elseif ($disk.DriveType -eq 3){
    Write-Host "Drive is fixed"
} elseif ($disk.DriveType -eq 5){
    Write-Host "Drive is optical"
} else {
    Write-Host "Drive is other"
}

# a posiible workaround for the issue above is:
$disk = Get-WmiObject -Class win32_logicaldisk 
$disk | ForEach-Object {
if($_.DriveType -eq 2){
    Write-Host "Drive is floppy"
} elseif ($_.DriveType -eq 3){
    Write-Host "Drive is fixed"
} elseif ($_.DriveType -eq 5){
    Write-Host "Drive is optical"
} else {
    Write-Host "Drive is other"
}}

## 2. Switch

# another construct that is more designed to case based scenarios. example
$disk = Get-WmiObject -Class win32_logicaldisk | select -First 1
switch($disk.DriveType){
    2 {Write-Host "floppy"}
    3 {Write-Host "fixes"}
    5 {
        Write-Host "optical"
      }
    default {"other"}
}

# another example
$name = Read-Host "enter server name"
switch -Wildcard ($name) {
    "*DC*" {
        "this is a domain controller"
        }
    "*FS*" {
        "this is a file server"
        }
    "*NYC*" {
        "this is in NYC"
        }
    "*LON*" {
        "this is in LON"
        }
}

# another example with break
$name = Read-Host "enter server name"
switch -Wildcard ($name) {
    "*DC*" {
        "this is a domain controller"
        break
        }
    "*FS*" {
        "this is a file server"
        break
        }
    "*NYC*" {
        "this is in NYC"
        break
        }
    "*LON*" {
        "this is in LON"
        break
        }
}

# see the help
help switch
help about_Switch

# play with regex. why there is an error?
$name = Read-Host "enter server name"
switch -regex ($name) {
    "*DC*" {
        "this is a domain controller"
        }
    "*FS*" {
        "this is a file server"
        }
    "*NYC*" {
        "this is in NYC"
        }
    "*LON*" {
        "this is in LON"
        }
}

# play with regex the correct way
$name = Read-Host "enter server name"
switch -regex ($name) {
    "DC" {
        "this is a domain controller"
        }
    "FS" {
        "this is a file server"
        }
    "NYC" {
        "this is in NYC"
        }
    "LON" {
        "this is in LON"
        }
}

# same as above with ifs
$name = Read-Host "enter server name"
if ($name -match "DC"){"a domain controller"}
if ($name -match "FS"){"a file server"}
if ($name -match "NYC"){"in NYC"}
if ($name -match "LON"){"in LON"}