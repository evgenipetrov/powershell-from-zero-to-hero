## Tricks

## dos commands
icacls /?

icacls D:\Temp /grant Administrator:(D,WDAC)

icacls D:\Temp /grant "Administrator:(D,WDAC)"

# PS v3+
icacls --% D:\Temp /grant Administrator:(D,WDAC)

## last exit code
ping localhost
$LASTEXITCODE

ping nonexistant
$LASTEXITCODE

## regex
$output = ping --% dc -4
$output
$regex = "\[(?'address'\S+)\]"
($output -match $regex)[0] -match $regex
$matches['address']

## wrappers
function Grant-Access {
    param (
        $username,
        $path
    )
    icacls $path /grant "$username:(D,WDAC)"
}