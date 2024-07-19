Set-Location C:\Setup

# ensure setup and ci directories exist
$null = New-Item -Path C:/Setup -Name Downloads -ItemType Directory -Force
$null = New-Item -Path C:/ -Name CI -ItemType Directory -Force

$Wrapper = "C:\Setup\vs_buildtools_wrapper.bat"
$InstallPath = "C:\CI\BuildTools"

$SetupUri = "https://aka.ms/vs/17/release/vs_buildtools.exe"
$SetupPath = "C:/Setup/Downloads/vs_buildtools.exe"

Invoke-WebRequest -Uri "${SetupUri}" -OutFile "${SetupPath}"

$ComponentsToAdd = @(
    "Microsoft.VisualStudio.Component.VC.v141.x86.x64"
)

$Args = $ComponentsToAdd | ForEach-Object { "--add" ; $_ }

# run the setup twice with the same arguments
& $Wrapper "${SetupPath}" "${InstallPath}" $Args
& $Wrapper "${SetupPath}" "${InstallPath}" $Args
