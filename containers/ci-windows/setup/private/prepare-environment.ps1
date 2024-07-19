
function Add-CIDirectory {
    param(
        [Parameter(Mandatory)] [string] $Path,
        [Parameter(Mandatory)] [string] $Name
    )
    $F = $MyInvocation.MyCommand

    $null = New-Item -Path $Path -Name $Name -ItemType Directory -Force
    Write-Host "[$F] Path=${Path} Name=${Name}"
}

Set-Location C:\Setup

Add-CIDirectory -Path C:/Setup -Name Downloads
Add-CIDirectory -Path C:/ -Name CI
