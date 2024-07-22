. C:/Setup/private/prelude.ps1

# put together the setup command line

$Wrapper = "C:\Setup\private\vs_buildtools_wrapper.bat"
$InstallPath = "C:\CI\BuildTools"

$SetupUri = "https://aka.ms/vs/17/release/vs_buildtools.exe"
$SetupPath = "C:/Setup/Downloads/vs_buildtools.exe"

Invoke-WebRequest -Uri "${SetupUri}" -OutFile "${SetupPath}"

$ComponentsToAdd = @(
    "Microsoft.VisualStudio.Component.Windows11SDK.22621"
    "Microsoft.VisualStudio.Component.VC.Tools.x86.x64"
    "Microsoft.VisualStudio.Component.VC.v141.x86.x64"
    "Microsoft.VisualStudio.Component.VC.14.29.16.11.x86.x64"
    "Microsoft.VisualStudio.Component.VC.14.40.17.10.x86.x64"
)

$SetupArgs = $ComponentsToAdd | ForEach-Object { "--add" ; $_ }

# run the setup twice with the same arguments

& $Wrapper "${SetupPath}" "${InstallPath}" $SetupArgs
& $Wrapper "${SetupPath}" "${InstallPath}" $SetupArgs
