<# 44. LOOPING CONSTRUCTS #>

## 1. ForEach

# example. start several processes then stop them with ForEach. every single object causes PS to parse the scriptblock
notepad;notepad;notepad

Get-Process -Name notepad |
ForEach-Object { $_.Kill() }

# more efficient way. start 100 notepads
1..100 | foreach { notepad }

Get-Process -Name notepad | Measure-Object

Measure-Command {
    Get-Process -Name notepad |
    ForEach-Object { $_.Kill() }
} 

# now example with the scripting construct. it is completely different! this is not a command!
1..100 | foreach { notepad }
$processes = Get-Process -Name notepad

foreach ($process in $processes){
    $process.Kill()
}

# let us measure it
1..100 | foreach { notepad }
$processes = Get-Process -Name notepad

Measure-Command{
    foreach ($jimmy in $processes){
        $jimmy.Kill()
    }
}

# what if we need to nest other constructs ?
1..100 | foreach { notepad }
$processes = Get-Process -Name notepad

foreach ($process in $processes){
    if($process.VM -gt 100){
        $process.Kill()
    }
}

## 2. For 

# example 
$array1 = "one","two","three","four","five"
$array2 = "fred","barney","wilma","betty","pebbles"
$string = "One day we saw two eating four"

for ([int]$x = 0; $x -lt $array1.Count; $x++){
    echo "Loop $x"
    $string = $string -replace $array1[$x],$array2[$x]
    }

$string

# another example
$array1 = "abv.bg","gmail.com","company.com"
$array2 = "evgeni@labs.com","outlook.com","company.pri"
$emails =   "evgeni@abv.bg",
            "ivan@gmail.com",
            "maria@company.com"

foreach($email in $emails){
    for ([int]$x = 0; $x -lt $array1.Count; $x++){
        
        $email = $email -replace $array1[$x],$array2[$x]
        }
    Write-Output $email
}

$emails

## 3. While / Do / Until

# example. note contains is case sensitive!
$existing = 'server1','server3','server4','server7', 'server2'

$candidate = 0
 do {
    $candidate++
    $possiblename = "server$candidate"
} while (-not $existing.Contains($possiblename))

$possiblename

# other variations. what is the difference?
while ($this -eq $that) {

}

do {

} until ($this -eq $that)

# example while/do
$this = 5
$that = 7
while ($this -eq $that) {
    write "hello"
    $this++
}

# example while/until
$this = 5
$that = 7
do {
    write "hello"
    $this++
} until ($this -eq $that)

# another example while/until
$this = 5
$that = 7
do {
    write "hello"
    $this++
} until ($true)