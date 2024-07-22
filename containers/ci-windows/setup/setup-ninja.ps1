. C:/Setup/private/prelude.ps1

$Version = "1.12.1"

Add-CIDirectory -Path C:/CI -Name Ninja
Add-CIDirectory -Path C:/CI/Ninja -Name bin

$ArchiveName = "ninja-win"
$ArchiveUri = "https://github.com/ninja-build/ninja/releases/download/v${Version}/${ArchiveName}.zip"

$NinjaDir = "C:\CI\Ninja"

Invoke-WebRequest -Uri "${ArchiveUri}" -OutFile "C:/Setup/Downloads/${ArchiveName}.zip"
Expand-Archive -Path "C:/Setup/Downloads/${ArchiveName}.zip" -DestinationPath "C:/Setup/Downloads/Ninja"
Move-Item -Path "C:/Setup/Downloads/Ninja/ninja.exe" "${NinjaDir}\bin"

# adjust persisted path environment variable
$MachinePath = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
[System.Environment]::SetEnvironmentVariable("Path", "${NinjaDir}\bin;${MachinePath}", "Machine")
