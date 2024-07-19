param(
    [string] $Version = "17"
)

& C:/Setup/private/prepare-environment.ps1

Write-Host "MSVC_ARCH=${env:MSVC_ARCH}"
Write-Host "MSVC_VERSION=${env:MSVC_VERSION}"
Write-Host "VISUAL_STUDIO_VERSION=${env:VISUAL_STUDIO_VERSION}"

$MsvcArch = "${env:MSVC_ARCH}"
$MsvcVersion = "${env:MSVC_VERSION}"
$VisualStudioVersion = "${env:VISUAL_STUDIO_VERSION}"

if (-not "$MsvcArch" -in @("x86.x64", "ARM", "ARM64")) {
    Write-Host "Invalid MSVC_ARCH=${MSVC_ARCH}! Must be one of x86.x64 ARM ARM64"
    exit 1
}

$Wrapper = "C:\Setup\vs_buildtools_wrapper.bat"
$InstallPath = "C:\CI\BuildTools"

$SetupUri = "https://aka.ms/vs/${Version}/release/vs_buildtools.exe"
$SetupPath = "C:/Setup/Downloads/vs_buildtools.exe"

Invoke-WebRequest -Uri "${SetupUri}" -OutFile "${SetupPath}"

$ComponentsToAdd = @()

if ("$MsvcVersion" -eq "v141") {
    $ComponentsToAdd += "Microsoft.VisualStudio.Component.VC.v141.${MsvcArch}"
} else {
    $ComponentsToAdd += "Microsoft.VisualStudio.Component.VC.${MsvcVersion}.${VisualStudioVersion}.${MsvcArch}"
}

$Args = $ComponentsToAdd | ForEach-Object { "--add" ; $_ }

# run the setup twice with the same arguments
& $Wrapper "${SetupPath}" "${InstallPath}" $Args
& $Wrapper "${SetupPath}" "${InstallPath}" $Args
