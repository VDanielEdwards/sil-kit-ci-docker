
$MachinePath = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
[System.Environment]::SetEnvironmentVariable("Path", "C:\CI\Scripts;${MachinePath}", "Machine")
