Write-Host "x is $x"

$x=200

Write-Host "In the script, x is $x"

function Foo {
    Write-Host "In the function, x is $x"
    $x=300
    Write-Host "Now , in the function, x is $x"

    $script:z = 10
}

Foo

Write-Host "At this point in the script, x is $x"

Set-Variable -Name z -Scope global -Value 1000
