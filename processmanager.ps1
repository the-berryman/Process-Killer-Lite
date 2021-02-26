# Declares the name of the user on the PC running the script, grabs the date and grabs the name of this file for display.
$myname = $env:USERNAME
$myDate = Get-Date
$version = Get-WindowsEdition -Online | Write-Host -ForegroundColor DarkCyan 
$myScriptName = $MyInvocation.MyCommand.Name

# Formats the display of the variables above to show up as green. Completes the heading section of the script
Write-Host -ForegroundColor Red "============================"
Write-Host -ForegroundColor Yellow " Name: $myName"
Write-Host -ForegroundColor Green " Date: $myDate"
Write-Host $version
Write-Host -ForegroundColor Cyan " Script: $myScriptName"

Write-Host -ForegroundColor Magenta "============================`n"

# Heading for displaying the windows services that are currently stopped
Write-Host "Windows Services"
Write-Host "****************"

# Gets the service where ther status is equal to stopped. Sorts the services by their name.
Get-Service | Where-Object {$_.status -eq 'Running'} | Sort-Object -Property DisplayName
Write-Host `n
Write-Host `n

# Heading for showing the Available interfaces that are currently active
Write-Host "Available Interfaces"
Write-Host "********************"

# Selects the Network adapters that are currently up. Formats them and shows the selected attributes.
Get-NetAdapter | Where-Object {$_.status -eq 'Up'} | Format-List Name,InterfaceDescription,InterfaceIndex,MacAddress,PhysicalMediaType,InterfaceOperationalStatus,AdminStatus,LinkSpeed,MediaConnectorPresent,DriverInformation


function main {

    $myprocess = Read-Host -Prompt 'Input the process you would like to search for'
    Get-Process | Where-Object {$_.ProcessName -eq $myprocess} | Sort-Object -Property ProcessName
    $choice = Read-Host -Prompt 'What would you like to do? Kill a process, or debug?'
    Write-Host $choice


    if ($choice -eq 'Kill') {

        Get-Process | Where-Object {$_.ProcessName -eq $myprocess} | Stop-Process
        Write-Host 'Processes killt ;)))'
        Pause
        main
        }

    elseif ($choice -eq 'Debug') {

        Get-Process | Where-Object {$_.ProcessName -eq $myprocess} | Debug-Process
        Write-Host 'Process debugging? maybe?'
        Pause
        main
        }

    else {
        Write-Host 'Not a valid input.'
        main
        }
        }

main







