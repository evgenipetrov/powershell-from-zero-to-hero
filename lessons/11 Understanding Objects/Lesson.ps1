## What is an object?

# .NET is object oriented, so is PS
# data structures

# class vs instance

Get-Service
# collections
# objects
# properties

Get-Service | Get-Member
Get-Service | gm

# notice type name

# notice the difference between screen output and get member

## Exploring objects
Get-Service | gm
Get-Service | Format-List -Property *

## Object documentation

# msdn, search for type name

## The ETS and adaptation

# alias properties
# events
# script properties - shortcuts to nested object properties

## Object members - properties, methods, events

# car.steering wheel.horn

Get-Service | Get-Member
Get-Process | Get-Member

# method arguments
# method chaining

## Playing with objects

# datetime
# string - tolower, toupper, replace
# process 

# object snapshots

# how to find files older than 35 days?
