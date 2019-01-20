<# 35. EXECUTING INSTANCE METHODS #>

## 1. Finding methods and documentation

# win7: note the getters and setters; setters sometimes do not work
Enter-PSSession -ComputerName win7.lab.pri
$disk = Get-WmiObject -Class win32_logicaldisk -Filter "deviceid='c:'"
$disk | gm

## 2. Executing methods via WMI

# try to change the volume name. where is this saved?
$disk.VolumeName = 'FIXED'
$disk

# try to save it now
$disk.put()
Get-WmiObject -Class win32_logicaldisk

# native vs powershell-added methods
Get-WmiObject -Class win32_operatingsystem | gm

# it is often easier to put the class into a variable
$os = Get-WmiObject -Class win32_operatingsystem
$os.ConvertToDateTime($os.InstallDate)

# manipulate the DateTime object
$os.ConvertToDateTime($os.InstallDate).toshortdatestring()

# note the local variable and the remote execution
exit
$win7=Get-WmiObject -ComputerName win7.lab.pri -Class win32_operatingsystem
$win7.Win32Shutdown(4)

# try another method another way
Get-WmiObject -Class win32_service -ComputerName dc.lab.pri,member.lab.pri -Filter "name='bits'" | Invoke-WmiMethod -Name StartService

# and another way. why this is not working?
Invoke-WmiMethod -Class win32_service -ComputerName dc.lab.pri -Name StartService

# try another method with multi arguments. what is the problem?
Get-WmiObject -Class win32_service -ComputerName dc.lab.pri | Invoke-WmiMethod -Name Change -ArgumentList $null,$null,$null,$null,$null,$null,$null,'password'

## 3. Executing methods via CIM

# same method execution with CIM
$service = Get-CimInstance -ClassName Win32_Service -ComputerName dc.lab.pri -Filter "name='bits'"
$service | Invoke-CimMethod -MethodName Change -Arguments @{StartPassword='password1'}

## 4. Enumerating to execute methods

# and another way to execute methods. the first line (commented) shows how I destroyed my DC
# Get-WmiObject -Class win32_service -ComputerName dc.lab.pri | ForEach-Object { $_.Change($null,$null,$null,$null,$null,$null,$null,'password') }
Get-WmiObject -Class win32_service -ComputerName dc.lab.pri -Filter "name='bits'"| ForEach-Object { $_.Change($null,$null,$null,$null,$null,$null,$null,'password') }

