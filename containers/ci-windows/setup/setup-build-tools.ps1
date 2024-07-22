. C:/Setup/private/prelude.ps1

Write-Host "ARCH=${env:ARCH}"
Write-Host "VC_VERSION=${env:VC_VERSION}"
Write-Host "VISUAL_STUDIO_VERSION=${env:VISUAL_STUDIO_VERSION}"

$Arch = "${env:ARCH}"
$VcVersion = "${env:VC_VERSION}"
$VisualStudioVersion = "${env:VISUAL_STUDIO_VERSION}"

# validate inputs

$ValidArchValues = @("x86", "x64", "arm", "arm64")
if (-not "$Arch" -in $ValidArchValues) {
    Write-Host "Invalid ARCH=${Arch}! Must be one of $($ValidArchValues -join ', ')"
    exit 1
}

# note: v141 requires special handling since the setup component is named differently

if (($VcVersion -ne "v141") -and ($VcVersion -notmatch '^14[.][234][0-9]$')) {
    Write-Host "Invalid VC_VERSION=${VcVersion}! Must be either 'v141' or match 14.NM with 2<=N<=4 and 0<=M<=9"
    exit 1
}

# process inputs into installer components

if (($Arch -eq "x86") -or ($Arch -eq "x64")) {
    $VcComponentArch = "x86.x64"
} elseif ($Arch -eq "arm") {
    $VcComponentArch = "ARM"
} elseif ($Arch -eq "arm64") {
    $VcComponentArch = "ARM64"
} else {
    Write-Host "Invalid ARCH=${Arch}!"
    exit 1
}

$VcComponentVersion = $VcVersion

# put together the setup command line

$Wrapper = "C:\Setup\private\vs_buildtools_wrapper.bat"
$InstallPath = "C:\CI\BuildTools"

$SetupUri = "https://aka.ms/vs/17/release/vs_buildtools.exe"
$SetupPath = "C:/Setup/Downloads/vs_buildtools.exe"

Invoke-WebRequest -Uri "${SetupUri}" -OutFile "${SetupPath}"

$ComponentsToAdd = @()

if ("$VcComponentVersion" -eq "v141") {
    # note: the version-specific component is not enough to get the compiler into the path through `VsDevCmd.bat`
    $ComponentsToAdd += "Microsoft.VisualStudio.Component.VC.Tools.${VcComponentArch}"
    $ComponentsToAdd += "Microsoft.VisualStudio.Component.VC.${VcComponentVersion}.${VcComponentArch}"
} else {
    $ComponentsToAdd += "Microsoft.VisualStudio.Component.VC.${VcComponentVersion}.${VisualStudioVersion}.${VcComponentArch}"
}

$SetupArgs = $ComponentsToAdd | ForEach-Object { "--add" ; $_ }

# run the setup twice with the same arguments

& $Wrapper "${SetupPath}" "${InstallPath}" $SetupArgs
& $Wrapper "${SetupPath}" "${InstallPath}" $SetupArgs

# capture and persist the environment variables prepared by the VsDevCmd bach file

function Invoke-VsDevCmd {
    param(
        [ValidateSet("x86", "x64", "arm", "arm64")]
        [string] $Arch = "${env:ARCH}",

        [ValidateSet("14.1", "14.2", "14.3", "14.4")]
        [string] $VcVersion = "${env:VC_VERSION}"
    )

    $BatchVCVarsAll = "( C:\CI\BuildTools\Common7\Tools\VsDevCmd.bat -arch=$Arch -host_arch=x64 -vcvars_ver=$VcVersion >NUL 2>&1 )"
    $BatchGetEnvironmentAsJson = "powershell -Command Get-ChildItem env: ^| Select-Object name,value ^| ConvertTo-Json"

    $EnvironmentJson = & cmd.exe /C "$BatchVCVarsAll && $BatchGetEnvironmentAsJson"

    foreach ($Var in ($EnvironmentJson | ConvertFrom-Json)) {
        [System.Environment]::SetEnvironmentVariable($Var.Name, $Var.Value, "Machine")
    }
}

if ("$VcVersion" -eq "v141") {
    Invoke-VsDevCmd -Arch $Arch -VcVersion "14.1"
} else {
    Invoke-VsDevCmd -Arch $Arch -VcVersion "$($VcVersion.Substring(0, 4))"
}
