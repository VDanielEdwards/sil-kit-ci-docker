Set-Location C:\Setup

# ensure setup and ci directories exist
$null = New-Item -Path C:/Setup -Name Downloads -ItemType Directory -Force
$null = New-Item -Path C:/ -Name CI -ItemType Directory -Force

$Version = "3.30.0"
$ArchiveName = "cmake-${Version}-windows-x86_64"
$ArchiveUri = "https://github.com/Kitware/CMake/releases/download/v${Version}/${ArchiveName}.zip"

$CMakePath = "C:\CI\CMake"

Invoke-WebRequest -Uri "${ArchiveUri}" -OutFile "C:/Setup/Downloads/${ArchiveName}.zip"
Expand-Archive -Path "C:/Setup/Downloads/${ArchiveName}.zip" -DestinationPath "C:/Setup/Downloads/CMake"
Move-Item -Path "C:/Setup/Downloads/CMake/${ArchiveName}" "${CMakePath}"

# adjust persisted path environment variable
$MachinePath = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
[System.Environment]::SetEnvironmentVariable("Path", "${CMakePath}\bin;${MachinePath}", "Machine")