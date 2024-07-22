
$MachinePath = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
[System.Environment]::SetEnvironmentVariable("Path", "C:\CI\Scripts;${MachinePath}", "Machine")

[System.Environment]::SetEnvironmentVariable("MSVC_ARCH", "${env:MSVC_ARCH}", "Machine")
[System.Environment]::SetEnvironmentVariable("MSVC_VERSION", "${env:MSVC_VERSION}", "Machine")
[System.Environment]::SetEnvironmentVariable("VISUAL_STUDIO_VERSION", "${env:VISUAL_STUDIO_VERSION}", "Machine")
